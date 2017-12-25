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
#import "BuriedPointManager.h"

#define DateFormat @"yyyy-MM-dd HH:mm:ss Z"
#define FilePath @"Log/Error"

#define ValidityOfLog  7

#import "AvoidCrash.h"

static LogManager *Loger = nil;

@implementation LogManager

+(instancetype)shareLoger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Loger = [[LogManager alloc] init];
        
    });
    
    return Loger;
}


#pragma mark - 神奇的load方法
+(void)load{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
#pragma mark - 网络实时监控
        [[LogManager shareLoger] reachabilityStatusMonitoring];
#pragma mark 开始埋点
        [BuriedPointManager becomeBuriedPoint];
#pragma mark 数据容错开启
        [[LogManager shareLoger] FaultTolerance];
#pragma mark 收集崩溃信息
        NSSetUncaughtExceptionHandler(&catchExceptionHandler);
        
    });
    
}
#pragma mark - 网络实时监控
-(void)reachabilityStatusMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                
                NSLog(@"无网络连接");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                
                NSLog(@"移动蜂窝网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"wifi网络");
            }
                break;
            case AFNetworkReachabilityStatusUnknown:{
                
                NSLog(@"无法获取网络状态");
            }
                break;
            default:
                break;
        }
        
    }];
}
#pragma mark - 开启容错
-(void)FaultTolerance
{
    
#if !DEBUG
    [AvoidCrash becomeEffective];//所有支持避免异常的数据类型统一处理
    //[NSMutableArray/NSArray avoidCrashExchangeMethod];//支持避免异常的数据类型单独处理
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [kNotificationCenter addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
#endif
    
}
#pragma mark - 数据容错后收集的数据崩溃信息
-(void)dealwithCrashMessage:(NSNotification *)notification
{
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",notification.userInfo);
    
}

#pragma mark 崩溃信息监控
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
    NSLog(@"%@",exceptionDic);
    
#if !DEBUG
    
    if ([LogManager CheckWriteCrashFileOnDocumentsException:exceptionDic]) {
        NSLog(@"Log writed!");
    }
#endif
    
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



- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}
@end
