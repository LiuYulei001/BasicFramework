//
//  LYLDataBaseManager.h
//  LYLDataBaseManager
//
//  Created by Rainy on 16/10/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYLDataBaseManager : NSObject


/*
 ********** Create table with tableName and fieldName **********
 *
 * @param   dataBaseName    tableNameString
 * @param   userInfoField   fieldNameString
 *
 * @return  if the table is successfully created
 *
 */
+ (BOOL)createDataBaseWithName:(NSString *)dataBaseName andUserInfoField:(NSString *)userInfoField;

/*
 ********** update specific userInfo with specific userID and userInfoField and userInfoValue **********
 *
 * @param   dataBaseName    tableNameString
 * @param   userID          userIDString
 * @param   userInfoField   fieldNameString
 * @param   userInfoValue   userInfoValueString
 *
 * @return  the result of updating specific userInfo
 *
 */
+ (NSString *)updateUserInfoIntoDataBase:(NSString *)dataBaseName withUserID:(NSString *)userID andUserInfoField:(NSString *)userInfoField andUserInfoValue:(id)userInfoValue;

/*
 ********** Query specific userInfoValue with tableName and userID and userInfoField **********
 *
 * @param   dataBaseName    tableNameString
 * @param   userID          userIDString
 * @param   userInfoField   fieldNameString
 *
 * @return  specific userInfoValue
 *
 */
+ (id)queryUserInfoInDataBase:(NSString *)dataBaseName WithUserID:(NSString *)userId andUserInfoField:(NSString *)userInfoField;

/*
 ********** Query all userInfos in this table with userInfoField **********
 *
 * @param   dataBaseName    tableNameString
 * @param   userInfoField   fieldNameString
 *
 * @return  all the userInfos in this table
 *
 */
+ (NSDictionary *)queryUserInfosInDataBase:(NSString *)dataBaseName andUserInfoField:(NSString *)userInfoField;

/*
 ********** Delete specific userInfo with specific userID **********
 *
 * @param   dataBaseName    tableNameString
 * @param   userId          userIDString
 *
 * @return  the result of deleting specific userInfo
 *
 */
+ (NSString *)deleteUserInfoInDataBase:(NSString *)dataBaseName WithUserID:(NSString *)userId;
/*
 ********** Delete all userInfo with specific dataBaseName **********
 *
 * @param   dataBaseName    tableNameString
 *
 * @return  the result of deleting all userInfo
 *
 */
+ (NSString *)deleteAllUserInfoTableInDataBase:(NSString *)dataBaseName;

@end
