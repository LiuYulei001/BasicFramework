//
//  NetWorkManager.h
//  PreheatDemo
//
//  Created by 星空浩 on 16/6/28.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkManager : NSObject
+ (instancetype)sharedInstance;


/**
 *  同步请求
 *
 *  @param RequestType POST or GET
 *  @param URL        地址
 *  @param parameters 参数
 *  @param Controller 控制器
 *  @param success
 *
 */
- (void)SynchronizationForRequestType:(NSString *)RequestType WithURL:(NSString *)URL parameters:(NSString *)parametersStr Controller:(UIViewController *)Controller success:(void(^)(id response,id data))success;
/**
 *  上传图片
 *
 *  @param image   上传图片
 *  @param url     地址
 *  @param userid  用户id
 *  @param success 成功block
 *  @param failure 失败block
 */
- (void)UploadPicturesToServerPic:(UIImage *)image url:(NSString *)url uiserid:(NSString *)userid success:(void (^)(id responseObject))success failure:(void (^)(NSError *  error))failure;
/**
 *  Post请求
 *
 *  @param URL        地址
 *  @param parameters 参数
 *  @param Controller 控制器
 *  @param success
 *  @param failure
 */
- (void)requestDataForPOSTWithURL:(NSString *)URL parameters:(id)parameters Controller:(UIViewController *)Controller success:(void(^)(id responseObject))success failure:(void (^)(NSError *  error))failure;
/**
 *  get请求
 *
 *  @param URL        地址
 *  @param Controller 控制器
 *  @param success
 *  @param failure
 */
-(void)requestDataForGETWithURL:(NSString *)URL parameters:(id)parameters Controller:(UIViewController *)Controller success:(void(^)(id responseObject))success failure:(void (^)(NSError *  error))failure;
/**
 *  上传文件
 *
 *  @param fileData 图片组
 *  @param params   其他参数
 *  @param result   成功回调
 *  @param failure  失败回调
 */
- (void)updateFile:(NSArray*)fileData url:(NSString*)url parameters:(NSMutableDictionary*)params fileName:(NSString*)fileName viewControler:(UIViewController*)vc success:(void(^)(id result))result failure:(void(^)(NSError *  error))failure;
/**
 *  清除用户信息
 */
-(void)clearUserCaches;

@end
