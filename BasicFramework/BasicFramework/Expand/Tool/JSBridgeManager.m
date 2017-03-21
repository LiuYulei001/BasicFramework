//
//  JSBridgeManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "JSBridgeManager.h"

static WKWebViewJavascriptBridge* _bridge;

@interface JSBridgeManager ()


@end

@implementation JSBridgeManager

+(WKWebViewJavascriptBridge *)createBridgeWithWebView:(WKWebView *)webView target:(id)target EnableLogging:(BOOL)logging
{
    if (logging) {
        
        [WKWebViewJavascriptBridge enableLogging];
    }
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:target];
    return _bridge;
}
+(void)registerHandler:(NSString *)handler bridgeHandler:(JSBridgeHandler)bridgeHandler
{
    if (!_bridge) { NSLog(@"未创建WKWebViewJavascriptBridge！") return; }
    [_bridge registerHandler:handler handler:^(id data, WVJBResponseCallback responseCallback){
        
        bridgeHandler(data,responseCallback);
        
    }];
}
+(void)callHandler:(NSString *)handler data:(id)data responseCallback:(JSBridgeCallback)responseCallback
{
    if (!_bridge) { NSLog(@"未创建WKWebViewJavascriptBridge！") return; }
    [_bridge callHandler:handler data:data responseCallback:^(id responseData) {
        
        responseCallback(responseData);
    
    }];
}
+(void)callHandler:(NSString *)handler data:(id)data
{
    if (!_bridge) { NSLog(@"未创建WKWebViewJavascriptBridge！") return; }
    [_bridge callHandler:handler data:data];
}
+(void)callHandler:(NSString *)handler
{
    if (!_bridge) { NSLog(@"未创建WKWebViewJavascriptBridge！") return; }
    [_bridge callHandler:handler];
}

@end
