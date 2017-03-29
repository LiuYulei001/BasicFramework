//
//  ZipFileArchiveManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//
NSString * const path_dataFileName = @"HTML_PACKAGE";
NSString * const path_unzipPressedFileName = @"HTML_directories.bundle";
NSString * const path_entranceHtmlFileName = @"index.html";
NSString * const path_tempZipFileName = @"TEMP_HTML_PACKAGE";

#define kProgressViewHeight 2.0f

#import "ZipFileArchiveManager.h"
#import "SSZipArchive.h"

@implementation ZipFileArchiveManager

+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                            Parameters:(NSDictionary *)parameters
                           isMandatory:(BOOL)isMandatory
                        downZipSuccess:(downZipSuccess)downZipSuccess
                        downZipFailure:(downZipFailure)downZipFailure
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, kScreenHeight - kProgressViewHeight, [[UIScreen mainScreen] bounds].size.width, kProgressViewHeight);
    progressView.progressTintColor = ThemeColor;
    progressView.trackTintColor = [UIColor clearColor];
    [kWindow addSubview:progressView];
    
    [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:Loading isTouched:NO inView:kWindow];
    
    [NetWorkManager downLoadFileWithParameters:parameters SavaPath:isMandatory ? [ZipFileArchiveManager filePath] : [ZipFileArchiveManager tempZipfilePath] UrlString:UrlString DownLoadProgress:^(float progress) {
        
        [progressView setProgress:progress animated:YES];
        
    } SuccessBlock:^(NSURLResponse *response, NSURL *filePath) {
        
        [progressView removeFromSuperview];
        
        [ProgressHUD hideProgressHUDAfterDelay:0];
        
        if (isMandatory) {
            
            BOOL success = [ZipFileArchiveManager unzipPressedAtzipPath:[NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],response.suggestedFilename]];
            
            if (success) {
                
                downZipSuccess([ZipFileArchiveManager entranceHtmlFilePath]);
            }
            
        }else
        {
            NSString *tempZipFilePath = [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager tempZipfilePath],response.suggestedFilename];
            [FileCacheManager saveInMyLocalStoreForValue:tempZipFilePath atKey:path_tempZipFileName];
            downZipSuccess(nil);
        }
        
        
    } FailureBlock:^(NSError *error) {
        
        [progressView removeFromSuperview];
        
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
        
        [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
    }
    return success;
}
+(BOOL)unzipPressedAtzipPath:(NSString *)zipPath
{
    
    BOOL success = [ZipFileArchiveManager unzipPressedAtdataPath:[ZipFileArchiveManager tempUnzipPressedFilePath] zipPath:zipPath];
    if (success) {
        
        [ZipFileArchiveManager clearWebCaches];
        [ZipFileArchiveManager clearOldFile];
        [[NSFileManager defaultManager] moveItemAtPath:[ZipFileArchiveManager tempUnzipPressedFilePath] toPath:[ZipFileArchiveManager unzipPressedFilePath] error:nil];
        
    }
    return success;
}
+(NSString *)unzipPressedFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],path_unzipPressedFileName];
}
+(NSString *)entranceHtmlFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager unzipPressedFilePath],path_entranceHtmlFileName];
}
+(NSString *)filePath
{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],path_dataFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSLog(@" HTML_PACKAGE filePath = %@",path);
    return path;
}
+(NSString *)tempUnzipPressedFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager tempZipfilePath],path_unzipPressedFileName];
}
+(NSString *)tempZipfilePath
{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],path_tempZipFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSLog(@" TEMP_HTML_PACKAGE filePath = %@",path);
    return path;
}
+(void)clearOldFile
{
    [FileCacheManager DeleteValueInMyLocalStoreForKey:path_tempZipFileName];
    [[NSFileManager defaultManager]removeItemAtPath:[ZipFileArchiveManager unzipPressedFilePath] error:nil];
}
+(void)clearWebCaches
{
    
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    
}

@end
