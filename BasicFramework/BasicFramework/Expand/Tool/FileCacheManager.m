//
//  FileCacheManager.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/16.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#define kCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define UserDefaults [NSUserDefaults standardUserDefaults]


#import "FileCacheManager.h"


@implementation FileCacheManager
/**
 *  获取本地相关类型的所有文件路径
 */
+(NSArray *)getFilePathsFromMainBundleForFileType:(NSString *)fileType
{
    NSString *bundlePath = [[NSBundle mainBundle]resourcePath];
    
    NSArray *resource_array = [NSBundle pathsForResourcesOfType:fileType inDirectory:bundlePath];
    
    return resource_array;
}

+ (NSInteger)fileSizeOfPath:(NSString *)filePath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:filePath isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:filePath];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [filePath stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:filePath error:nil][NSFileSize] integerValue];
    }
}



#pragma mark - * * * * * * * * * * * * * * File Manager * * * * * * * * * * * * * *

// 把对象归档存到沙盒里
+ (BOOL)saveObject:(id)object byFileName:(NSString *)fileName {
    NSString *path  = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    BOOL success = [NSKeyedArchiver archiveRootObject:object toFile:path];
    return success;
    
}

// 通过文件名从沙盒中找到归档的对象
+ (id)getObjectByFileName:(NSString*)fileName {
    NSString *path  = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    id obj =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}

// 根据文件名删除沙盒中的文件
+ (void)removeObjectByFileName:(NSString *)fileName {
    NSString *path  = [self appendFilePath:fileName];
    path = [path stringByAppendingString:@".archive"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (NSString *)appendFilename:(NSString *)fileName {
    
    // 1. 沙盒缓存路径
    NSString *cachesPath = kCachesPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachesPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return cachesPath;
}

// 拼接文件路径
+ (NSString *)appendFilePath:(NSString *)fileName {
    
    // 1. 沙盒缓存路径
    NSString *cachesPath = kCachesPath;
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",cachesPath,fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return filePath;
}

#pragma mark - * * * * * * * * * * * * NSUserDefaults Manager * * * * * * * * * * * *

+(void)saveInMyLocalStoreForValue:(id)value atKey:(NSString *)key
{
    [UserDefaults setValue:value forKey:key];
    [UserDefaults synchronize];
}
+(id)getValueInMyLocalStoreForKey:(NSString *)key
{
    return [UserDefaults objectForKey:key];
}
+(void)DeleteValueInMyLocalStoreForKey:(NSString *)key
{
    [UserDefaults removeObjectForKey:key];
    [UserDefaults synchronize];
}



@end
