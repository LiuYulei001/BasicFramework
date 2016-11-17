//
//  FileCacheManager.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/16.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCacheManager : NSObject

/**
 *  获取本地相关类型的所有文件路径
 */
+(NSArray *)getFilePathsFromMainBundleForFileType:(NSString *)fileType;
/**
 *  获取本地文件内容的大小
 */
+ (NSInteger)fileSizeOfPath:(NSString *)filePath;

#pragma mark - * * * * * * * * * * * * * * File Manager * * * * * * * * * * * * * *

/**
 *  把对象归档存到沙盒里Cache路径下
 */
+ (BOOL)saveObject:(id)object byFileName:(NSString*)fileName;

/**
 *  通过文件名从沙盒中找到归档的对象
 */
+ (id)getObjectByFileName:(NSString*)fileName;

/**
 *  根据文件名删除沙盒中的归档对象
 */
+ (void)removeObjectByFileName:(NSString*)fileName;


#pragma mark - * * * * * * * * * * * * NSUserDefaults Manager * * * * * * * * * * * *

/**
 *  存储value
 */
+(void)saveInMyLocalStoreForValue:(id)value atKey:(NSString *)key;
/**
 *  获取value
 */
+(id)getValueInMyLocalStoreForKey:(NSString *)key;
/**
 *  删除value
 */
+(void)DeleteValueInMyLocalStoreForKey:(NSString *)key;

@end
