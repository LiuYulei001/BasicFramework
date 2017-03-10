//
//  LogManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/9.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LogManager.h"
#import <mach-o/dyld.h>
#import <mach-o/loader.h>

#define DateFormat @"yyyy-MM-dd HH:mm:ss Z"
#define FilePath @"Log/Error"

#define ValidityOfLog  7

@implementation LogManager

void catchExceptionHandler (NSException *exception){
    
    if (exception==nil) return;
    //异常的堆栈信息
    NSArray  *stackArrays = [exception callStackSymbols];
    //异常原因
    NSString *reason = [exception reason];
    //异常类型
    NSString  *name   = [exception name];
    
    NSMutableDictionary *exceptionDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [exceptionDic setValue:reason forKey:@"exceptionReason"];
    [exceptionDic setValue:name forKey:@"exceptionName"];
    [exceptionDic setValue:stackArrays forKey:@"callStackSymbols"];
    
    if ([LogManager CheckWriteCrashFileOnDocumentsException:exceptionDic]) {
        NSLog(@"Log writed!");
    }
}

#pragma mark - 获取dSYM UUID方法
static  NSUUID *ExecutabUUID (void ){
    
    const  struct mach_header  *executableHeader =NULL;
    
    for (uint32_t  i = 0 ; i<_dyld_image_count(); i++) {
        
        const struct mach_header *header =_dyld_get_image_header(i);
        
        if (header ->filetype ==MH_EXECUTE) {
            
            executableHeader =header;
            
            break;
        }
        
    }
    
    if (!executableHeader) return nil;
    
    BOOL  is64bit  =executableHeader ->magic ==MH_EXECUTE ||executableHeader->magic == MH_CIGAM_64 ;
    
    uintptr_t cursor  = (uintptr_t)executableHeader + (is64bit ? sizeof(struct mach_header_64) : sizeof(struct mach_header));
    
    const struct segment_command *segmentCommand = NULL;
    
    for (uint32_t i = 0; i < executableHeader->ncmds; i++, cursor += segmentCommand->cmdsize)
    {
        segmentCommand = (struct segment_command *)cursor;
        
        if (segmentCommand->cmd == LC_UUID)
        {
            const struct uuid_command *uuidCommand = (const struct uuid_command *)segmentCommand;
            return [[NSUUID alloc] initWithUUIDBytes:uuidCommand->uuid];
        }
    }
    
    return nil;
    
}
#pragma mark - 检查异常并写入沙河文档
+(BOOL)CheckWriteCrashFileOnDocumentsException:(NSDictionary *)exceptionDic{
    
    NSString *DateTime = [[NSDate date] stringWithFormat:DateFormat];
    
    //设备信息
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSMutableDictionary *deviceInfos = [NSMutableDictionary dictionary];
    
    [deviceInfos setValue:[infoDic objectForKey:@"DTPlatformVersion"] forKey:@"DTPlatformVersion"];
    
    [deviceInfos setValue:[infoDic objectForKey:@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
    
    [deviceInfos setValue:[infoDic objectForKey:@"UIRequiredDeviceCapabilities"] forKey:@"UIRequiredDeviceCapabilities"];
    
    
    NSString *crashname = [NSString stringWithFormat:@"%@_%@_%@Crashlog.log",ExecutabUUID(),DateTime,infoDic[@"CFBundleName"]];
    
    NSString *crashPath = [[self getFilePath] stringByAppendingString:FilePath];
    
    NSFileManager *manger = [NSFileManager defaultManager];
    
    BOOL isSuccess = [manger createDirectoryAtPath:crashPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (isSuccess) {
        
        NSLog(@"文件夹创建成功");
        
        NSString *filepath = [crashPath stringByAppendingPathComponent:crashname];
        
        NSMutableDictionary *logs = [NSMutableDictionary dictionaryWithContentsOfFile:filepath];
        
        if (!logs) {
            
            logs  = [NSMutableDictionary dictionaryWithCapacity:0];
        }
        
        NSDictionary *infos = @{@"Exception":exceptionDic,@"DeviceInfo":deviceInfos};
        
        [logs setValue:infos forKey:[NSString stringWithFormat:@"%@_crashLogs",infoDic[@"CFBundleName"]]];
        
        BOOL writeOK = [logs writeToFile:filepath atomically:YES];
        
        NSLog(@"write result = %d,filePath = %@",writeOK,filepath);
        return writeOK;
    }else{
        
        return  NO;
    }
    
}

#pragma mark - 获取日志
+(NSArray *)getCrashLog {
    
    NSString *crashFilePath =   [[self getFilePath] stringByAppendingString:FilePath];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *fileArray = [manager contentsOfDirectoryAtPath:crashFilePath error:nil];
    
    NSMutableArray *results= [NSMutableArray arrayWithCapacity:0];
    
    if (fileArray.count ==0)return nil;
    
    for (NSString *fileName in fileArray) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[crashFilePath stringByAppendingPathComponent:fileName]];
        
        [results addObject:dict];
    }
    
    return results;
}
#pragma mark - 清理过期日志 有效期(7天)
+(void)clearCrashLog{
    
    NSString *crashFilePath =  [[self getFilePath]stringByAppendingString:FilePath];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:crashFilePath]) return;
    
    NSArray *crashLogContents = [manager contentsOfDirectoryAtPath:crashFilePath error:NULL];
    
    if (crashLogContents.count==0) return;
    
    [crashLogContents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self interval:[crashFilePath stringByAppendingPathComponent:obj]]>ValidityOfLog) {
            
            [manager removeItemAtPath:[crashFilePath stringByAppendingPathComponent:obj] error:nil];
        }
    }];
    
}
#pragma mark - 创建文件路径
+(NSString *)getFilePath{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
#pragma mark - 通过路径获取文件创建的时间距今多久
+(NSInteger )interval:(NSString *)path{
    
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSString *dateString = [NSString stringWithFormat:@"%@",[attributes fileModificationDate]];
    
    NSDate *formatterDate = [NSDate dateWithString:dateString format:DateFormat];
    return [formatterDate daysAgo];
    
}


@end
