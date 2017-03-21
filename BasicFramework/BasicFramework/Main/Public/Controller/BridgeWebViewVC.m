//
//  BridgeWebViewVC.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BridgeWebViewVC.h"
#import "JSBridgeManager.h"
#import "JSWKWebView.h"

@interface BridgeWebViewVC ()<WKNavigationDelegate>

@property(nonatomic,strong)JSWKWebView *webParentView;

@end

@implementation BridgeWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBridge];
    [self registerHandlerForLoadData];
    [self createReloadButton:self.webParentView.webView];
    [self loadHtmlPageInWebView:self.webParentView.webView];
    
}
#pragma mark - reateBridge
-(void)createBridge
{
    [JSBridgeManager createBridgeWithWebView:self.webParentView.webView target:self EnableLogging:YES];
}
#pragma mark - registerHandler
-(void)registerHandlerForLoadData
{
    [JSBridgeManager registerHandler:@"loadData" bridgeHandler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSLog(@"loadData called: %@", data);
        responseCallback(@"Response from loadData");
        
    }];
}
#pragma mark - callHandlerAction
- (void)callHandlerActionForLogin {
    
    id data = @{@"name":@"test",@"passWord":@"998899"};
    
    [JSBridgeManager callHandler:@"toLogin" data:data responseCallback:^(id response) {
        
        NSLog(@"toLogin responded: %@", response);
        
    }];
}

- (void)createReloadButton:(WKWebView*)webView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:webView action:@selector(reload)];
}


#pragma mark - loadHtmlPageInWebView
- (void)loadHtmlPageInWebView:(WKWebView*)webView {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}



#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"webViewDidFailLoad");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSString *requestString = navigationResponse.response.URL.absoluteString;
    
    if ([requestString rangeOfString:@"监听并拦截含有字段的链接"].location != NSNotFound) {
        
        //对拦截到的相应字段做相应操作
        
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //判断服务器返回的证书类型, 是否是服务器信任
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        /*
         NSURLSessionAuthChallengeUseCredential = 0,                     使用证书
         NSURLSessionAuthChallengePerformDefaultHandling = 1,            忽略证书(默认的处理方式)
         NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,     忽略书证, 并取消这次请求
         NSURLSessionAuthChallengeRejectProtectionSpace = 3,             拒绝当前这一次, 下一次再询问
         */
        
        //        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling , card);
    }
}



#pragma mark - lazy
-(JSWKWebView *)webParentView
{
    if (!_webParentView) {
        
        _webParentView = [[JSWKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.webParentView];
    }
    return _webParentView;
}

@end
