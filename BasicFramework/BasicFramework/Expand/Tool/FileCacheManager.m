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

+(NSArray *)getFilePathsFromMainBundleForFileType:(NSString *)fileType
{
    NSString *bundlePath = [[NSBundle mainBundle]resourcePath];
    
    NSArray *resource_array = [NSBundle pathsForResourcesOfType:fileType inDirectory:bundlePath];
    
    return resource_array;
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
