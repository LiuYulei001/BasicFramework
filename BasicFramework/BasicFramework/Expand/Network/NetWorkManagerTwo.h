//
//  NetWorkManagerTwo.h
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//


typedef NS_ENUM(NSUInteger, requestType) {
    GET = 1,
    POST
};

#import <AFNetworking/AFNetworking.h>

typedef void(^requestSucces)(id responseObject, id data);
typedef void(^requestFailure)( NSError *error);
typedef void(^uploadProgress)(float progress);

@interface NetWorkManagerTwo : AFHTTPSessionManager

/**
 *  数据网络请求
 */
+(void)requestDataWithURL:(NSString *)url
              requestType:(requestType)requestType
               parameters:(id)parameters
           uploadProgress:(uploadProgress)progress
                  success:(requestSucces)success
                  failure:(requestFailure)failure;
/**
 *  上传图片：@[UIImage,UIImage...]
 */
+(void)uploadPicturesWithURL:(NSString *)URL
                  parameters:(id)parameters
                      images:(NSArray *)images
                    progress:(uploadProgress)progress
                     success:(requestSucces)success
                     failure:(requestFailure)failure;
/**
 *  上传语音：@[@"filePath",@"filePath"...]
 */
+(void)uploadAudioRecordWithURL:(NSString *)URL
                     parameters:(id)parameters
                          audio:(NSArray *)audio
                 UploadProgress:(uploadProgress)progress
                        success:(requestSucces)success
                        failure:(requestFailure)failure;

@end
