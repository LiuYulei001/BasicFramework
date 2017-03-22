//
//  ZipFileArchiveManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kDataFileName         @"HTML_PACKAGE"
#define kZipFileName          @"HTML.zip"
#define kunzipPressedFileName @"HTML_directories"
#define kEntranceHtmlFileName @"index.html"

#import "ZipFileArchiveManager.h"
#import "SSZipArchive.h"

@implementation ZipFileArchiveManager

+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                             Parameters:(NSDictionary *)parameters
                         downZipSuccess:(downZipSuccess)downZipSuccess
                         downZipFailure:(downZipFailure)downZipFailure
{
    
    
    [NetWorkManager downLoadFileWithParameters:parameters SavaPath:[ZipFileArchiveManager zipFilePath] UrlString:UrlString DownLoadProgress:^(float progress) {
        
        
        
    } SuccessBlock:^(NSURLResponse *response, NSURL *filePath) {
        
        [[NSFileManager defaultManager]removeItemAtPath:[ZipFileArchiveManager unzipPressedFilePath] error:nil];
        BOOL success = [ZipFileArchiveManager unzipPressedAtdataPath:[ZipFileArchiveManager filePath] zipPath:[ZipFileArchiveManager zipFilePath]];
        if (success) {
            downZipSuccess([ZipFileArchiveManager entranceHtmlFilePath]);
        }
        
    } FailureBlock:^(NSError *error) {
        
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:DownLoad_Failure afterDelay:HUD_DismisTime isTouched:NO inView:kWindow];
        downZipFailure(error);
        
    }];
}

+(BOOL)zipPressedFileAtZipPath:(NSString *)zipPath
                      dataPath:(NSString *)dataPath
{
    return [SSZipArchive createZipFileAtPath:zipPath withContentsOfDirectory:dataPath];
}
+(BOOL)unzipPressedAtdataPath:(NSString *)dataPath
                      zipPath:(NSString *)zipPath
{
    BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:dataPath];
    if (success) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[ZipFileArchiveManager zipFilePath] error:nil];
    }
    return success;
}

+(NSString *)unzipPressedFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],kunzipPressedFileName];
}
+(NSString *)entranceHtmlFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager unzipPressedFilePath],kEntranceHtmlFileName];
}
+(NSString *)zipFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],kZipFileName];
}
+(NSString *)filePath
{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0],kDataFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSLog(@" HTML_PACKAGE filePath = %@",path);
    return path;
}


@end
