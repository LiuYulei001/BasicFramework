//  LYLDataBaseManager.h
//  LYLDataBaseManager
//
//  Created by Rainy on 16/10/17.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "LYLDataBaseManager.h"
#import "FMDatabase.h"


#ifdef DEBUG
#define SJLog(...) NSLog(__VA_ARGS__)
#define SJMethod() NSLog(@"%s", __func__)
#else
#define SJLog(...)
#define SJMethod()
#endif

#define PATH_OF_DOCUMENT_FOLDER    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation LYLDataBaseManager

+ (BOOL)createDataBaseWithName:(NSString *)dataBaseName andUserInfoField:(NSString *)userInfoField
{
    
    BOOL result = YES;
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]) {
        
        NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
        FMDatabase * db = [FMDatabase databaseWithPath:path];
        
        if ([db open]) {
            
            NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT NOT NULL, %@ TEXT NOT NULL)",dataBaseName,userInfoField];
            
            BOOL res = [db executeUpdate:sql];
            
            if (!res) {
                
                SJLog(@"error when creating db table");
                [db close];
                result = NO;
                
            } else {
                
                SJLog(@"succ to creating db table");
                [db close];
                result = YES;
            }
            
        } else {
            
            SJLog(@"error when open db");
            result = NO;
            
        }
        
    }else{
        
        result = YES;
    }
    
    return result;
}

+ (NSString *)updateUserInfoIntoDataBase:(NSString *)dataBaseName withUserID:(NSString *)userID andUserInfoField:(NSString *)userInfoField andUserInfoValue:(id)userInfoValue
{
    NSString *result = @"";
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]){
        
        result = @"This dataBase not exists!";
        
    }else{
        
        NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
        FMDatabase * db = [FMDatabase databaseWithPath:path];

        
        if ([self currentUserInfoExistsInDataBase:dataBaseName WithUserId:userID]) {
            
            //if userId exists,change the user_info
            if ([db open]) {
                
                NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE  user_id = ?",dataBaseName,userInfoField];
                BOOL res = [db executeUpdate:sql,userInfoValue,userID];
                
                if (!res) {
                    
                    SJLog(@"error to update data");
                    result = @"Failed to update data!";
                    
                } else {
                    
                    SJLog(@"succ to update data");
                    result = @"Successfully update data!";
                    
                }
                
                [db close];
            }
            
            
        }else{
           
            //if userId not exists,add the user_info
            if ([db open]) {
               
                NSString * sql = [NSString stringWithFormat:@"insert into %@ (user_id, %@) values(?, ?)",dataBaseName,userInfoField];
                
                BOOL res = [db executeUpdate:sql, userID, userInfoValue];
                
                if (!res) {
                    
                    SJLog(@"error to insert data");
                    result = @"Failed to insert data!";
                    
                } else {
                    
                    SJLog(@"succ to insert data");
                    result = @"Successfully insert data!";
                }
                
                [db close];
            }
            
        }
        
    }

    return result;
}


+ (id)queryUserInfoInDataBase:(NSString *)dataBaseName WithUserID:(NSString *)userId andUserInfoField:(NSString *)userInfoField
{
    NSString *result = @"";
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]){
        
        result = @"This dataBase not exists!";
        return result;
        
    }else{
        
        NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
        FMDatabase * db = [FMDatabase databaseWithPath:path];
        if ([db open]) {
            
            NSString * sql = [NSString stringWithFormat: @"select * from %@",dataBaseName];
            FMResultSet * rs = [db executeQuery:sql];
            
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:20 ];
            while ([rs next]) {
                NSString * user_id = [rs stringForColumn:@"user_id"];
                NSString * uesrInfoValue = [rs stringForColumn:userInfoField];
                NSDictionary *dict = @{
                                       @"user_id":user_id,
                                       userInfoField:uesrInfoValue
                                       };
                [array addObject:dict];
            }
            [db close];
            
            __block BOOL found = NO;
            __block id userInfoValue = nil;
            [array enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([[dict objectForKey:@"user_id"] isEqualToString:userId]) {
                    found = YES;
                    userInfoValue = [dict objectForKey:userInfoField];
                    *stop = YES;
                    
                }
                
            }];
            
            if (!found) {
                result = @"This userId not exists!";
                return result;
            }else{
                return userInfoValue;
            }
        }
    }
    return nil;
}

+ (NSDictionary *)queryUserInfosInDataBase:(NSString *)dataBaseName andUserInfoField:(NSString *)userInfoField
{
    NSDictionary *userInfosDict = nil;
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]){
        
        userInfosDict = @{@"result":@"This dataBase not exists!",
                          @"userInfosArray":@[]
                          };
        
    }else{
        
        NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
        FMDatabase * db = [FMDatabase databaseWithPath:path];
        if ([db open]) {
            
            NSString * sql = [NSString stringWithFormat: @"select * from %@",dataBaseName];
            FMResultSet * rs = [db executeQuery:sql];
            
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:20 ];
            
            while ([rs next]) {
                
                NSString * user_id = [rs stringForColumn:@"user_id"];
                NSString * uesrInfoValue = [rs stringForColumn:userInfoField];
                NSDictionary *dict = @{
                                       @"user_id":user_id,
                                       userInfoField:uesrInfoValue
                                       };
                [array addObject:dict];
            }
            [db close];
            
            if ([array count] == 0) {
                
                userInfosDict = @{@"result":@"This dataBase is empty!",
                                  @"userInfosArray":@[]
                                  };
                
            }else{
                
                NSArray *userInfosArray = [array copy];
                userInfosDict = @{
                                  @"result":@"This database is not empty",
                                  @"userInfosArray":userInfosArray
                                  };
            }
        }
    }
    return userInfosDict;
}

+ (NSString *)deleteUserInfoInDataBase:(NSString *)dataBaseName WithUserID:(NSString *)userId
{
    NSString *result = @"";
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]) {
        
        result = @"This dataBase not exists!";
        
    }else{
        
        if ([self currentUserInfoExistsInDataBase:dataBaseName WithUserId:userId]){
            
            NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
            FMDatabase * db = [FMDatabase databaseWithPath:path];
            
            if ([db open]) {
                BOOL suc = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE user_id = ?",dataBaseName],userId];
                
                [db close];
                if (suc) {
                    result = @"Delete Successfully";
                }else{
                    result = @"Delete Failed";
                }
                
            }
        }else{
            
            result = @"This userId not exists!";

        }
        
        
    }
    
    return result;
}

+ (NSString *)dataBaseFilePathWithDataBaseName:(NSString *)dataBaseName
{
    NSString * doc = PATH_OF_DOCUMENT_FOLDER;
    NSString * path = [doc stringByAppendingPathComponent:dataBaseName];
    return path;
}

+ (BOOL)needCreateDateBaseWithDataBaseName:(NSString *)dataBaseName
{
    
    NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return NO;
    }else{
        return YES;
    }
}


+ (BOOL)currentUserInfoExistsInDataBase:(NSString *)dataBaseName WithUserId:(NSString *)idString
{
    BOOL exist = NO;
    
    NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        
        NSString * sql = [NSString stringWithFormat: @"select * from %@",dataBaseName];
        FMResultSet * rs = [db executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:20];
        
        while ([rs next]) {
            NSString * user_id = [rs stringForColumn:@"user_id"];
            [array addObject:user_id];
        }
        [db close];
        
        __block BOOL found = NO;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([(NSString *)obj isEqualToString:idString])
            {
                found = YES;
                *stop = YES;
            }
        }];
        
        if (!found) {
            exist = NO;
        }else{
            exist = YES;
        }
    }
    
    [db close];
    
    return exist;
}
+ (NSString *)deleteAllUserInfoTableInDataBase:(NSString *)dataBaseName
{
    NSString *result = @"";
    
    if ([self needCreateDateBaseWithDataBaseName:dataBaseName]) {
        
        result = @"This dataBase not exists!";
        
    }else{
        
        NSString * path = [self dataBaseFilePathWithDataBaseName:[NSString stringWithFormat:@"%@.sqlite",dataBaseName]];
        FMDatabase * db = [FMDatabase databaseWithPath:path];
        
        if ([db open]) {
            BOOL suc = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",dataBaseName]];
            
            [db close];
            if (suc) {
                result = @"Delete all Successfully";
            }else{
                result = @"Delete all Failed";
            }
            
        }
        
        
    }
    
    return result;
}
@end
