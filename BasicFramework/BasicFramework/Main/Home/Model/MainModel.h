//
//  MainModel.h
//  BasicFramework
//
//  Created by Rainy on 2016/11/14.
//  Copyright © 2016年 Rainy. All rights reserved.
//


#import <JSONModel/JSONModel.h>

@protocol ProductModel

@end

@interface ProductModel : JSONModel

@property(nonatomic,copy)NSString *name;
//不想因为服务器的某个值没有返回就使程序崩溃， 我们会加关键字Optional.
@property(nonatomic,copy)NSString <Optional>*userid;
@property(nonatomic,copy)NSString *sex;

@end

@interface MainModel : JSONModel

@property(nonatomic,copy)NSString *team;
@property(nonatomic,copy)NSString *teamID;
@property(nonatomic,strong)NSArray<ProductModel>* mans;


@end
