//
//  BasicConstants.h
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//


/**
 *  传入设计师提供的宽度获得适配屏幕的真实宽度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designWidth 设计师提供的宽度
 *
 *  @return 适配屏幕的真实宽度
 */
static inline CGFloat xmc_realWidth(CGFloat designWidth)
{
    return  (designWidth / 750.0) * ([UIScreen mainScreen].bounds.size.width);
}

/**
 *  传入设计师提供的高度获得适配屏幕的真实高度（我们设计师提供的图片的标准是iPhone 6(@2x) : 750 x 1334）
 *
 *  @param designHeight 设计师提供的高度
 *
 *  @return 适配屏幕的真实高度
 */
static inline CGFloat xmc_realHeight(CGFloat designHeight)
{
    return  (designHeight / 1334.0) * ([UIScreen mainScreen].bounds.size.height);
}


/**
 *  reload BanksList NotificationName
 */
extern NSString *const _NotificationNameForAppDelegateBackOff;
/**
 *  SuspensionTopViewDisapper NotificationName
 */
extern NSString *const kSuspensionViewDisNotificationName;
/**
 *  SuspensionViewShow NotificationName
 */
extern NSString *const kSuspensionViewShowNotificationName;
/**
 *  ReloadRecorderList NotificationName
 */
extern NSString *const kReloadRecorderListNotificationName;


/**
 *  USER_ID_KEY
 */
extern NSString* const kUSER_ID_KEY;
/**
 *  TOKEN_ID_KEY
 */
extern NSString* const kTOKEN_ID_KEY;
/**
 *  AUTO_KEY
 */
extern NSString* const kAUTO_KEY;
/**
 *  STOREID_KEY
 */
extern NSString* const kSTOREID_KEY;


/**
 *  How many cell per page
 */
extern NSInteger const kPageCap;
/**
 *  The time interval to send verification code (s)
 */
extern NSInteger const kAgainToGetCodeWaitTime;
/**
 *  Timeout interval
 */
extern NSTimeInterval const kRequestTimeoutInterval;


/**
 *  Prompt dismisTime
 */
extern NSTimeInterval const kPrompt_DismisTime;
/**
 *  dismis time
 */
extern NSTimeInterval const HUD_DismisTime;
/**
 *  alpha
 */
extern CGFloat const kAlpha;


/**
 *  prompt message
 */
extern NSString* const Loading;
extern NSString* const Request_Failure;
extern NSString* const Request_Success;
extern NSString* const Request_NOMore;
extern NSString* const Request_NoNetwork;
extern NSString* const DownLoad_Failure;
extern NSString* const kLoadedAll;
extern NSString* const kUploadImage_error;
extern NSString* const kUploadAudio_error;
