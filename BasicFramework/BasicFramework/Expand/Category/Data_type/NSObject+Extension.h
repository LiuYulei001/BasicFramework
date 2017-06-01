//
//  NSObject+Extension.h
//  BasicFramework
//
//  Created by Rainy on 2017/1/13.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timingChildThreadsBlock)(NSObject *obj,NSTimeInterval TimeIntervalNow);

@interface NSObject (Extension)
//倒计时器停止时间timeout，多久走一次TimeInterval，timingChildThreadsBlock子线程操作
-(void)startTimingWithTimeOut:(NSTimeInterval)timeout TimeInterval:(NSTimeInterval)TimeInterval timingChildThreadsBlock:(timingChildThreadsBlock)timingChildThreadsBlock;
//倒计时停止
-(void)stopCountDown;
//回到主线程
-(void)dispatch_get_main_queue:(void(^)())main_queue;
#pragma mark - 获取最新一张图片
+ (void)GetlatestImageForTakeScreenshot:(BOOL)isTakeScreenshot finished:(void (^)(UIImage *image))finished;
#pragma mark - 获取相簿所有图片
+(void)GetAllImagesInPhotoAlbumFinished:(void (^)(NSMutableArray *images))Finished;

#pragma mark - 手机震动
+(void)iPhoneVibration;


@end
