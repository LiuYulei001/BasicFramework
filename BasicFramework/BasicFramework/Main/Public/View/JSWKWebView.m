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

@interface JSWKWebView ()

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
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = kMinimumFontSize;
        configuration.preferences = preferences;
        
        WKWebView *WK_web = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
        
        self.webView = WK_web;
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault ];
        progressView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kProgressViewHeight);
        progressView.progressTintColor = ThemeColor;
        progressView.trackTintColor = [UIColor clearColor];
        
        self.progressView = progressView;
        
        [self addSubview:WK_web];

        [self insertSubview:progressView aboveSubview:WK_web];
        
        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progress = self.webView.estimatedProgress;
        
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

@end
