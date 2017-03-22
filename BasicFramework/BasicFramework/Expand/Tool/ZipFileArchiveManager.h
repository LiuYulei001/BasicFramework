//
//  ZipFileArchiveManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//

typedef void(^downZipSuccess)(NSString *filePath);
typedef void(^downZipFailure)(NSError *error);

#import <Foundation/Foundation.h>

@interface ZipFileArchiveManager : NSObject

+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                            Parameters:(NSDictionary *)parameters
                        downZipSuccess:(downZipSuccess)downZipSuccess
                        downZipFailure:(downZipFailure)downZipFailure;

+(BOOL)zipPressedFileAtZipPath:(NSString *)zipPath dataPath:(NSString *)dataPath;

+(BOOL)unzipPressedAtdataPath:(NSString *)dataPath zipPath:(NSString *)zipPath;

+(NSString *)filePath;

+(NSString *)zipFilePath;

+(NSString *)entranceHtmlFilePath;

+(NSString *)unzipPressedFilePath;

@end
