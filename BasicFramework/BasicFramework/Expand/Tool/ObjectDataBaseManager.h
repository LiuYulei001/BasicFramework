//
//  ObjectDataBaseManager.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/15.
//  Copyright © 2016年 Rainy. All rights reserved.
//
/*===============================================================================
 
 LYLDataBaseManager的二次封装，本地化对象；
 
 ===============================================================================*/

#import <Foundation/Foundation.h>
#import "MainModel.h"

@interface ObjectDataBaseManager : NSObject
/** 创建数据库 */
+ (BOOL)createDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;
/** 更新／添加对象到数据库 */
+ (NSString *)updateModel:(MainModel *)Model forDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;
/** 根据ID查询对象 */
+ (MainModel *)queryModelOfID:(NSString *)ID InDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;
/** 查询表内所有对象 */
+ (NSArray *)queryAllModelInDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;
/** 删除指定对象 */
+ (NSString *)deleteModelOfModel:(MainModel *)Model InDataBase:(NSString *)dataBase;
/** 删除表内所有对象 */
+ (NSString *)deleteAllModelInDataBase:(NSString *)dataBase;

@end
