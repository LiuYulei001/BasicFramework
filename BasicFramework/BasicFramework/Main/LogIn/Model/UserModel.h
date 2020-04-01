//
//  UserModel.h
//  BasicFramework
//
//  Created by Rainy on 2016/12/19.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserModel : JSONModel

//用户ID
@property(nonatomic,copy)NSString *UserID;
//用户姓名
@property(nonatomic,copy)NSString *UserName;

@end
