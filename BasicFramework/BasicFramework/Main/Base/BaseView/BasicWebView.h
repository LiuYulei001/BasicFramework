//
//  BasicWebView.h
//  CashBack
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BasicWebView : UIView

-(instancetype)initWithFrame:(CGRect)frame canCopy:(BOOL)canCopy canZoom:(BOOL)canZoom;
@property(nonatomic,strong)WKWebView *webView;

@end

