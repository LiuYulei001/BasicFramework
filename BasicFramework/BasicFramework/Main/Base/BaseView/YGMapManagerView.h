//
//  YGMapManagerView.h
//  CashBack
//
//  Created by Rainy on 2017/12/4.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef void(^LatitudeAndLongitude)(CLLocationDegrees latitude,CLLocationDegrees longitude);
typedef void(^Address)(NSString *address);

@interface YGMapManagerView : UIView

/** @[YGAnnotation] */
@property(nonatomic,strong)NSArray *annotationPins;
/** 获取当前位置 */
- (void)getCurrentLocation:(LatitudeAndLongitude)latitudeAndLongitude
                   address:(Address)address;
/** 自带地图app导航 */
+ (void)navigateTolatitude:(CLLocationDegrees)latitude
                 longitude:(CLLocationDegrees)longitude;

@end
