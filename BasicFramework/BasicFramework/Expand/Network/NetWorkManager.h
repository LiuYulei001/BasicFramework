//
//  NetWorkManager.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**定义请求成功的block*/
typedef void(^requestSuccess)(id responseObject);
/**定义请求失败的block*/
typedef void(^requestFailure)( NSError *error);
/**定义上传进度block*/
typedef void(^uploadProgress)(float progress);
/**定义下载进度block*/
typedef void(^downloadProgress)(float progress);
/**下载成功的block*/
typedef void(^downloadSuccess)(NSURLResponse *response, NSURL *filePath);

@interface NetWorkManager : AFHTTPSessionManager

/**
 *  手机唯一标示
 */
+(NSString *)getUUID;
/**
 *  同步请求
 *
 *  @param RequestType POST or GET
 *  @param URL         地址
 *  @param parameters  参数
 *  @param Controller  控制器
 *  @param success
 *
 */
+(void)SynchronizationForRequestType:(NSString *)RequestType
                                 URL:(NSString *)URL
                          parameters:(NSString *)parametersStr
                          Controller:(UIViewController *)Controller
                             success:(void(^)(id response,id data,NSError *error))success;
/**
 *  Post请求
 *
 *  @param URL        地址
 *  @param parameters 参数
 *  @param Controller 控制器
 *  @param progress
 *  @param success
 *  @param failure
 */
+(void)requestDataForPOSTWithURL:(NSString *)URL
                      parameters:(id)parameters
                      Controller:(UIViewController *)Controller
                  UploadProgress:(uploadProgress)progress
                         success:(requestSuccess)success
                         failure:(requestFailure)failure;
/**
 *  get请求
 *
 *  @param URL        地址
 *  @param Controller 控制器
 *  @param progress
 *  @param success
 *  @param failure
 */
+(void)requestDataForGETWithURL:(NSString *)URL
                     parameters:(id)parameters
                     Controller:(UIViewController *)Controller
                 UploadProgress:(uploadProgress)progress
                        success:(requestSuccess)success
                        failure:(requestFailure)failure;
/**
 *  上传图片
 *
 *  @param parameters  上传图片预留参数---视具体情况而定 可移除
 *  @param images      上传的图片数组
 *  @param width       图片要被压缩到的宽度
 *  @param urlString   上传的url
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 *  @param progress    上传进度
 */
+(void)UploadPicturesWithURL:(NSString *)URL
                  parameters:(id)parameters
                      images:(NSArray *)images
                 targetWidth:(CGFloat )width
              UploadProgress:(uploadProgress)progress
                     success:(requestSuccess)success
                     failure:(requestFailure)failure;
/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString    上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */
+(void)uploadVideoWithParameters:(NSDictionary *)parameters
                       VideoPath:(NSString *)videoPath
                       UrlString:(NSString *)urlString
                  UploadProgress:(uploadProgress)progress
                    SuccessBlock:(requestSuccess)successBlock
                    FailureBlock:(requestFailure)failureBlock;
/**
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString    请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */
+(void)downLoadFileWithParameters:(NSDictionary *)parameters
                         SavaPath:(NSString *)savePath
                        UrlString:(NSString *)urlString
                 DownLoadProgress:(downloadProgress)progress
                     SuccessBlock:(downloadSuccess)successBlock
                     FailureBlock:(requestFailure)failureBlock;
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string;
/**
 *  取消所有的网络请求
 */
+(void)cancelAllRequest;
/**
 *  清除用户信息
 */
+(void)clearUserCaches;

@end
