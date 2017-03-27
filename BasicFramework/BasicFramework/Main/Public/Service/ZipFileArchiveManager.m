//
//  ZipFileArchiveManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kDataFileName         @"HTML_PACKAGE"
#define kunzipPressedFileName @"HTML_directories.bundle"
#define kEntranceHtmlFileName @"index.html"

#import "ZipFileArchiveManager.h"
#import "SSZipArchive.h"

@implementation ZipFileArchiveManager

+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                            Parameters:(NSDictionary *)parameters
                        downZipSuccess:(downZipSuccess)downZipSuccess
                        downZipFailure:(downZipFailure)downZipFailure
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0, kScreenHeight - 2, [[UIScreen mainScreen] bounds].size.width, 2);
    progressView.progressTintColor = ThemeColor;
    progressView.trackTintColor = [UIColor clearColor];
    [kWindow addSubview:progressView];
    
    [ProgressHUD showProgressHUDWithMode:ProgressHUDModeActivityIndicator withText:Loading isTouched:NO inView:kWindow];
    
    [NetWorkManager downLoadFileWithParameters:parameters SavaPath:[ZipFileArchiveManager filePath] UrlString:UrlString DownLoadProgress:^(float progress) {
        
        [progressView setProgress:progress animated:YES];
        
    } SuccessBlock:^(NSURLResponse *response, NSURL *filePath) {
        
        [progressView removeFromSuperview];
        
        [ProgressHUD hideProgressHUDAfterDelay:0];
        
        [ZipFileArchiveManager clearWebCaches];
        
        BOOL success = [ZipFileArchiveManager unzipPressedAtdataPath:[ZipFileArchiveManager unzipPressedFilePath] zipPath:[NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],response.suggestedFilename]];
        if (success) {
            downZipSuccess([ZipFileArchiveManager entranceHtmlFilePath]);
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

+(NSString *)unzipPressedFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager filePath],kunzipPressedFileName];
}
+(NSString *)entranceHtmlFilePath
{
    return [NSString stringWithFormat:@"%@/%@",[ZipFileArchiveManager unzipPressedFilePath],kEntranceHtmlFileName];
}
+(NSString *)filePath
{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],kDataFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSLog(@" HTML_PACKAGE filePath = %@",path);
    return path;
}
+(void)clearWebCaches
{
    [[NSFileManager defaultManager]removeItemAtPath:[ZipFileArchiveManager unzipPressedFilePath] error:nil];
    
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    
}

@end
