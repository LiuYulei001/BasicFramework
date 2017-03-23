//
//  ObjectDataBaseManager.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/15.
//  Copyright © 2016年 Rainy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MainModel.h"

@interface ObjectDataBaseManager : NSObject

+ (BOOL)createDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;

+ (NSString *)updateModel:(MainModel *)Model forDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;

+ (MainModel *)queryModelOfID:(NSString *)ID InDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;

+ (NSArray *)queryAllModelInDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;

+ (NSString *)deleteModelOfModel:(MainModel *)Model InDataBase:(NSString *)dataBase;

+ (NSString *)deleteAllModelInDataBase:(NSString *)dataBase;

@end
