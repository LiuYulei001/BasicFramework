//
//  BridgeWebViewVC.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/21.
//  Copyright © 2017年 Rainy. All rights reserved.
//
/*===============================================================================
 
 WKWebView的基础控制器，可被继承；
 
 ===============================================================================*/

#import "BasicMainVC.h"
#import "JSBridgeManager.h"
#import "JSWKWebView.h"

@interface BridgeWebViewVC : BasicMainVC<WKNavigationDelegate>

@property(nonatomic,strong)JSWKWebView *webParentView;


@end
