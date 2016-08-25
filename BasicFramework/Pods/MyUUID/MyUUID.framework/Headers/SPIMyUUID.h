
#import <Foundation/Foundation.h>

@interface SPIMyUUID : NSObject


+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
