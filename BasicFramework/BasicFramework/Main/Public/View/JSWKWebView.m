//
//  JSWKWebView.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#define kProgressViewHeight 2.0f
#define kMinimumFontSize    13.0f

#import "JSWKWebView.h"

@interface JSWKWebView ()<WKUIDelegate>

@property(nonatomic, strong)UIProgressView *progressView;
@property(nonatomic,assign)CGFloat progress;

@end

@implementation JSWKWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:[self javascriptOfCSS] injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addUserScript:noneSelectScript];
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = kMinimumFontSize;
        configuration.preferences = preferences;
        
        WKWebView *WK_web = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];

        self.webView = WK_web;
        WK_web.UIDelegate = self;
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault ];
        progressView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kProgressViewHeight);
        progressView.progressTintColor = ThemeColor;
        progressView.trackTintColor = [UIColor clearColor];
        
        self.progressView = progressView;
        
        [self addSubview:WK_web];

        [self insertSubview:progressView aboveSubview:WK_web];
        
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progress = self.webView.estimatedProgress;
        
    }else if ([keyPath isEqualToString:@"title"]){
        
        UIViewController *vc = [self viewController];
        vc.title = self.webView.title;
        
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (self.progressView.alpha == 0) {self.progressView.alpha = 1;}
    [self.progressView setProgress:progress animated:YES];
    if (progress >= 1) {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            self.progressView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            self.progressView.progress = 0;
        }];
    }
}
- (NSString *)javascriptOfCSS
{
    /*
     js-禁止手势缩放，自适应屏幕尺寸
     <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
     */
    // 禁止选择CSS
    NSString *css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";
    // CSS选中样式取消
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    return javascript;
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}






#pragma mark - <WKUIDelegate>
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
    
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
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
    
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
    
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    NSLog(@"webViewDidCreateWebView");
    if (!navigationAction.targetFrame.isMainFrame) {
        
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"webViewDidClose");
}
#endif

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}
@end
