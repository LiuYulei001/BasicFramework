//
//  JSBridgeManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//
/*===============================================================================
 
 此工具类用于本地跟Html5交互 包含：创建实例、注册本地方法、调取Html5注册的方法；
 
 ===============================================================================*/

#import <Foundation/Foundation.h>
#import "WKWebViewJavascriptBridge.h"

typedef void (^JSBridgeHandler)(id data, WVJBResponseCallback responseCallback);
typedef void (^JSBridgeCallback)(id responseData);

@interface JSBridgeManager : NSObject

/** 第一步先创建 */
+(WKWebViewJavascriptBridge *)createBridgeWithWebView:(WKWebView *)webView
                                               target:(id)target
                                        EnableLogging:(BOOL)logging;

/** 注册本地方法 */
+(void)registerHandler:(NSString *)handler bridgeHandler:(JSBridgeHandler)bridgeHandler;

/** 调取Html5注册的方法->需要传参及回调 */
+(void)callHandler:(NSString *)handler data:(id)data responseCallback:(JSBridgeCallback)responseCallback;

/** 调取Html5注册的方法->需要传参不需要回调 */
+(void)callHandler:(NSString *)handler data:(id)data;

/** 调取Html5注册的方法->不需要传参也不需要回调 */
+(void)callHandler:(NSString *)handler;

@end
