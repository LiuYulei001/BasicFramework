//
//  RequestTool.h
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRequestTool.h"
#import "HomeRequestTool.h"

@interface RequestTool : NSObject

+ (instancetype)sharedRequestTool;

/** 用户 */
@property(nonatomic,strong)UserRequestTool        *userRequestTool;
/** 首页 */
@property(nonatomic,strong)HomeRequestTool        *homeRequestTool;

@end
