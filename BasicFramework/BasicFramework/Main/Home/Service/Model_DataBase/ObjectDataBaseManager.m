//
//  ObjectDataBaseManager.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/15.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "ObjectDataBaseManager.h"

@implementation ObjectDataBaseManager


+ (BOOL)createDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField
{
    return [LYLDataBaseManager createDataBaseWithName:dataBase andUserInfoField:ValueField];
}

+ (NSString *)updateModel:(MainModel *)Model forDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField;
{
    NSString *modelStr = [Model toJSONString];
    return [LYLDataBaseManager updateUserInfoIntoDataBase:dataBase withUserID:Model.dataBase_ID andUserInfoField:ValueField andUserInfoValue:modelStr];
}

+ (MainModel *)queryModelOfID:(NSString *)ID InDataBase:(NSString *)dataBase  ValueField:(NSString *)ValueField
{
    NSString *modelStr = [LYLDataBaseManager queryUserInfoInDataBase:dataBase WithUserID:ID andUserInfoField:ValueField];
    NSError *error;
    MainModel *model = [[MainModel alloc]initWithString:modelStr error:&error];
    
    return error ? nil : model;
}

+ (NSArray *)queryAllModelInDataBase:(NSString *)dataBase ValueField:(NSString *)ValueField
{
    NSDictionary *dic = [LYLDataBaseManager queryUserInfosInDataBase:dataBase andUserInfoField:ValueField];
    /*
     
     {"result":@"This dataBase not exists!",
     "userInfosArray":@[]
     };
     
     
     {
     @"user_id":user_id,
     userInfoField:uesrInfoValue
     };
     
     */
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *temp_dic in dic[@"userInfosArray"]) {
        
        MainModel *model = [[MainModel alloc]initWithString:temp_dic[ValueField] error:nil];
        [modelArr addObject:model];
    }
    
    return modelArr;
}

+ (NSString *)deleteModelOfModel:(MainModel *)Model InDataBase:(NSString *)dataBase;
{
    return [LYLDataBaseManager deleteUserInfoInDataBase:dataBase WithUserID:Model.dataBase_ID];
}

+ (NSString *)deleteAllModelInDataBase:(NSString *)dataBase
{
    return [LYLDataBaseManager deleteAllUserInfoTableInDataBase:dataBase];
}

@end
