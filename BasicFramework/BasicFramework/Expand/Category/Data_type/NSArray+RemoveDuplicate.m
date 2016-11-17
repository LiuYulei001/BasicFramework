//
//  NSArray+RemoveDuplicate.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "NSArray+RemoveDuplicate.h"

@implementation NSArray (RemoveDuplicate)
- (instancetype)noRepeatArray {
    return [self newArrayWithArray:self.mutableCopy];
}

- (NSMutableArray *)newArrayWithArray:(NSMutableArray *)array {
    
    NSMutableArray *newArray = [NSMutableArray new];
    
    for (unsigned i = 0; i < [array count]; i++) {
        if (![newArray containsObject:array[i]]) {
            [newArray addObject:array[i]];
        }
    }
    return newArray;
}
@end
