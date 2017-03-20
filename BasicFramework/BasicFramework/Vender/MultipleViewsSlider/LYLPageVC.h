//
//  LYLPageVC.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYLPageVCDelegate <NSObject>

@required
-(void)pageVCDidFinishSelectedAtIndex:(NSInteger )index;

@end

@interface LYLPageVC : UIViewController

@property(nonatomic,assign)id<LYLPageVCDelegate> delegate;
@property(nonatomic,strong)NSArray *controllers;

-(void)setCurentControllerAtIndex:(NSInteger )index;

@end
