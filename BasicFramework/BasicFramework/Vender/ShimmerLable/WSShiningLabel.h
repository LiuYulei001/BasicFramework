//
//  WSShiningLabel.h
//  WSShiningLabel
//
//  Created by iMac on 16/11/18.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ST_LeftToRight,         // 从左到右
    ST_RightToLeft,         // 从右到左
    ST_AutoReverse,         // 左右来回
    ST_ShimmerAll,          // 整体闪烁
} ShimmerType;              // 闪烁类型


@interface WSShiningLabel : UIView

// UILabel 常用属性
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) NSAttributedString *attributedText;
@property (assign, nonatomic) NSInteger numberOfLines;

// CKShimmerLabel 属性
@property (assign, nonatomic) ShimmerType shimmerType;          // 闪烁类型，默认LeftToRight
@property (assign, nonatomic) BOOL repeat;                      // 循环播放，默认是
@property (assign, nonatomic) CGFloat shimmerWidth;             // 闪烁宽度，默认20
@property (assign, nonatomic) CGFloat shimmerRadius;            // 闪烁半径，默认20
@property (strong, nonatomic) UIColor *shimmerColor;            // 闪烁颜色，默认白
@property (assign, nonatomic) NSTimeInterval durationTime;      // 持续时间，默认2秒

- (void)startShimmer;   // 开始闪烁，闪烁期间更改上面属性立即生效
- (void)stopShimmer;    // 停止闪烁

@end

