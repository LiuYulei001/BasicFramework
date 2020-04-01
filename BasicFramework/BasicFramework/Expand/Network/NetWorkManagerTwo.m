//
//  NetWorkManagerTwo.m
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kNetWorkManager                  [NetWorkManagerTwo sharedInstance]

#import "NetWorkManagerTwo.h"

@interface NetWorkManagerTwo ()

@end

@implementation NetWorkManagerTwo

static NetWorkManagerTwo *network = nil;
+ (instancetype)sharedInstance;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[NetWorkManagerTwo alloc]initWithBaseURL:[NSURL URLWithString:_Environment_Domain]];
        
    });
    return network;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.responseSerializer.stringEncoding = NSUTF8StringEncoding;
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy = securityPolicy;
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];
        
        self.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        self.operationQueue.maxConcurrentOperationCount = 2;
        
        self.requestSerializer.cachePolicy = NSURLRequestReloadRevalidatingCacheData;
        
        [self.requestSerializer setTimeoutInterval:kRequestTimeoutInterval];
    }
    return self;
}
+(void)requestDataWithURL:(NSString *)url
              requestType:(requestType)requestType
               parameters:(id)parameters
           uploadProgress:(uploadProgress)progress
                  success:(requestSucces)success
                  failure:(requestFailure)failure
{
    
    if (kWindow) {
        
        [ProgressHUD showProgressHUDWithMode:0 withText:Loading isTouched:NO inView:kWindow];
    }
    
    
    switch (requestType) {
        case POST:
        {
            
            [NetWorkManagerTwo requestOfPOSTWithURL:url parameters:parameters uploadProgress:progress success:success failure:failure];
        }
            
            break;
        case GET:
        {
            
            [NetWorkManagerTwo requestOfGETWithURL:url parameters:parameters uploadProgress:progress success:success failure:failure];
        }
            
            break;
            
        default:
            break;
    }
    
}
+(void)requestOfPOSTWithURL:(NSString *)url
                 parameters:(id)parameters
             uploadProgress:(uploadProgress)progress
                    success:(requestSucces)success
                    failure:(requestFailure)failure
{
    [kNetWorkManager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            
            progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ProgressHUD hideProgressHUDAfterDelay:0];
        
        if (![responseObject[@"code"] isEqualToString:@"SUCC"]) {
            
            [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:responseObject[@"message"] afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
            failure(nil);
        }else
        {
            if (success) {
                success(responseObject,responseObject[@"data"]);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:Request_NoNetwork afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
        failure(error);
        
    }];
}
+(void)requestOfGETWithURL:(NSString *)url
                parameters:(id)parameters
            uploadProgress:(uploadProgress)progress
                   success:(requestSucces)success
                   failure:(requestFailure)failure
{
    [kNetWorkManager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            
            progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [ProgressHUD hideProgressHUDAfterDelay:0];
        
        if (![responseObject[@"code"] isEqualToString:@"SUCC"]) {
            
            [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:responseObject[@"message"] afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
            failure(nil);
            
        }else
        {
            
            if (success) {
                success(responseObject,responseObject[@"data"]);
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:Request_NoNetwork afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
        failure(error);
        
    }];
}


+(void)uploadPicturesWithURL:(NSString *)URL
                  parameters:(id)parameters
                      images:(NSArray *)images
                    progress:(uploadProgress)progress
                     success:(requestSucces)success
                     failure:(requestFailure)failure
{
    [kNetWorkManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images) {
            
            //            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            
            NSData * imgData = UIImageJPEGRepresentation(image, 0.1);
            
            [formData appendPartWithFileData:imgData name:@"file" fileName:@"img.png" mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            
            progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        success(responseObject,responseObject[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:kUploadImage_error afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
        failure(error);
        
    }];
}
+(void)uploadAudioRecordWithURL:(NSString *)URL
                     parameters:(id)parameters
                          audio:(NSArray *)audio
                 UploadProgress:(uploadProgress)progress
                        success:(requestSucces)success
                        failure:(requestFailure)failure
{
    [kNetWorkManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSString * mp3Url in audio) {
            
            [formData appendPartWithFileURL:[NSURL URLWithString:mp3Url] name:@"file" fileName:@"audioRecord.mp3" mimeType:@"application/octer-stream" error:nil];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            
            progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        success(responseObject,responseObject[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUD showProgressHUDWithMode:ProgressHUDModeOnlyText withText:kUploadAudio_error afterDelay:HUD_DismisTime isTouched:YES inView:kWindow];
        failure(error);
        
    }];
}

+(NSString *)randomString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss_"];
    return [formatter stringFromDate:[NSDate date]];
}


@end
