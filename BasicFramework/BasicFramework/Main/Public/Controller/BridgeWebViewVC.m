//
//  BridgeWebViewVC.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BridgeWebViewVC.h"


@interface BridgeWebViewVC ()
@end

@implementation BridgeWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBridge];
    
    //=============================================================================
    [self webViewReload];
    [self registerHandlerForLoadData];
    [self callHandlerActionForLogin];
    [self createReloadButton:self.webParentView.webView];
    //=============================================================================
    
}
#pragma mark - reateBridge
-(void)createBridge
{
    [JSBridgeManager createBridgeWithWebView:self.webParentView.webView target:self EnableLogging:YES];
}

//=============================================================================
#pragma mark - createReloadButton
- (void)createReloadButton:(WKWebView*)webView {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:webView action:@selector(reload)];
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
    
    [JSBridgeManager callHandler:@"Login" data:data responseCallback:^(id response) {
        
        NSLog(@"toLogin responded: %@", response);
        
    }];
}
#pragma mark - loadHtmlPageInWebView
- (void)webViewReload {
    
//本地html文件访问
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        [self.webParentView.webView loadFileURL:baseURL allowingReadAccessToURL:baseURL];
        
    } else {
        
        [self.webParentView.webView loadHTMLString:appHtml baseURL:baseURL];
        
    }
}
//=============================================================================

#pragma mark - <WKUIDelegate>
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"webViewDidFailLoad");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
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
