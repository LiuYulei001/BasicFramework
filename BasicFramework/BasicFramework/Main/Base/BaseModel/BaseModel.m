//
//  BaseModel.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel
/*
===========================================================
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
===========================================================
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (propertyValue)
        {
            [aCoder encodeObject:propertyValue forKey:propertyName];
        }
    }
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super init];
    if (self)
    {
        unsigned int outCount, i;
        objc_property_t *properties =class_copyPropertyList([self class], &outCount);
        
        for (i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            
            NSString *capital = [[propertyName substringToIndex:1] uppercaseString];
            NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[propertyName substringFromIndex:1]];
            
            SEL sel = NSSelectorFromString(setterSelStr);
            
            [self performSelectorOnMainThread:sel
                                   withObject:[aCoder decodeObjectForKey:propertyName]
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
    return self;
}

@end
