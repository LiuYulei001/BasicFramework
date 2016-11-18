//
//  MainModel.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/14.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "MainModel.h"


@implementation ProductModel


@end

@implementation MainModel


/*
 
 自定义model ： 第三方“ kObjectCodingAction ”//相当于以下代码实现
 
@synthesize team,dataBase_ID,mans;

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:team forKey:@"team"];
    [aCoder encodeObject:dataBase_ID forKey:@"dataBase_ID"];
    [aCoder encodeObject:mans forKey:@"mans"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        team =  [aDecoder decodeObjectForKey:@"team"];
        dataBase_ID = [aDecoder decodeObjectForKey:@"dataBase_ID"];
        mans =  [aDecoder decodeObjectForKey:@"mans"];
    }
    
    return self;
}
#pragma mark-NSCopying
-(id)copyWithZone:(NSZone *)zone{
    
    MainModel *model = [[[self class] allocWithZone:zone] init];
    model.team = [self.team copyWithZone:zone];
    model.mans = [self.mans copyWithZone:zone];
    
    return model;
}
*/
@end
