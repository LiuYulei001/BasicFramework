//
//  URLConstants.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/16.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#pragma mark -  * * * * * * * * * * * * * * 域名切换 * * * * * * * * * * * * * *

#define ENVIRONMENT 0

#if ENVIRONMENT == 0
/**
 *  @param 开发环境
 */
NSString *const _Environment_Domain = @"_API_Domain_开发环境";

#elif ENVIRONMENT ==1
/**
 *  @param 测试环境
 */
NSString *const _Environment_Domain = @"_API_Domain_测试环境";

#elif ENVIRONMENT ==2
/**
 *  @param 正式环境
 */
NSString *const _Environment_Domain = @"_API_Domain_正式环境";

#else

NSString *const _Environment_Domain = @"_NULL_";

#endif /* HTTPURLDefine_h */


#pragma mark -  * * * * * * * * * * * * * * URLs * * * * * * * * * * * * * *


NSString * const _URL_PageDetail = @"/pageDetail/";
NSString * const _URL_HomeList   = @"/homeList/";


