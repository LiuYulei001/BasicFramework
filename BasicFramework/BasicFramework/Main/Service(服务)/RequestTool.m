//
//  RequestTool.m
//  BasicFramework
//
//  Created by Rainy on 2017/10/30.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+ (instancetype)sharedRequestTool
{
    static RequestTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            
            tool = [RequestTool new];
            
            tool.userRequestTool    = [UserRequestTool new];
            tool.homeRequestTool    = [HomeRequestTool new];
        }
    });
    return tool;
}

@end
