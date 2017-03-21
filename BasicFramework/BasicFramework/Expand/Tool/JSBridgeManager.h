//
//  JSBridgeManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKWebViewJavascriptBridge.h"

typedef void (^JSBridgeHandler)(id data, WVJBResponseCallback responseCallback);
typedef void (^JSBridgeCallback)(id responseData);

@interface JSBridgeManager : NSObject

+(WKWebViewJavascriptBridge *)createBridgeWithWebView:(WKWebView *)webView target:(id)target EnableLogging:(BOOL)logging;
+(void)registerHandler:(NSString *)handler bridgeHandler:(JSBridgeHandler)bridgeHandler;

+(void)callHandler:(NSString *)handler data:(id)data responseCallback:(JSBridgeCallback)responseCallback;
+(void)callHandler:(NSString *)handler data:(id)data;
+(void)callHandler:(NSString *)handler;

@end
