//
//  BasicWebVC.m
//  CashBack
//
//  Created by Rainy on 2017/4/11.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BasicWebVC.h"
#import "BasicWebView.h"

@interface BasicWebVC ()<WKNavigationDelegate>

@property(nonatomic,strong)BasicWebView *webParentView;

@end

@implementation BasicWebVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!CGRectIsEmpty(self.viewFrame)) self.view.frame = self.viewFrame;
}

-(void)reloadWebView:(NSString *)htmlUrlStr
{
    [self.webParentView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_Environment_Domain,htmlUrlStr]]]];
}

#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidStartLoad"
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.webParentView.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webParentView.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    //"webViewDidFinishLoad"
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidFailLoad"
    [ProgressHUD showProgressHUDInView:kWindow withText:Request_NoNetwork afterDelay:HUD_DismisTime];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //"webViewWillLoadData"
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //"webViewWillAuthentication"
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling , nil);
}



#pragma mark - lazy
-(BasicWebView *)webParentView
{
    if (!_webParentView) {
        
        _webParentView = [[BasicWebView alloc] initWithFrame:self.view.bounds];
        _webParentView.webView.navigationDelegate = self;
        [self.view addSubview:self.webParentView];
    }
    return _webParentView;
}

@end
