//
//  NSObject+NSCoding.h
//  OpenStack
//
//  Created by Michael Mayo on 3/4/11.
//  The OpenStack project is provided under the Apache 2.0 license.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (NSCoding)

- (void)autoEncodeWithCoder: (NSCoder *)coder;
- (void)autoDecode:(NSCoder *)coder;
- (NSDictionary *)properties;

@end
