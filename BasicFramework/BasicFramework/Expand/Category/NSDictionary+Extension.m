//
//  NSDictionary+Extension.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/9.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString*)DictionaryConversionStringOfJson

{
    if (!self) {
        return nil;
    }
    
    NSError *parseError;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if (parseError) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
