# LYLDataBase
本地化数据


首先建议cocoapods导入此库：


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


platform :ios, ‘7.0’

target ‘Your project name’ do

  pod 'LYLDataBase', '~> 1.0.4'

end


＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

第一：创建数据库

    [LYLDataBaseManager createDataBaseWithName:kTempDataBaseName andUserInfoField:kUserInfoField];

第二：增删改查一句话

    NSDictionary *dic = @{@"name":@"小渣",@"sex":@"女",@"number":@"12"};
    NSString *str = @"王六";
    
    增加／修改：
    [LYLDataBaseManager updateUserInfoIntoDataBase:kTempDataBaseName withUserID:@"001" andUserInfoField:kUserInfoField andUserInfoValue:dic];

    [LYLDataBaseManager updateUserInfoIntoDataBase:kTempDataBaseName withUserID:@"002" andUserInfoField:kUserInfoField andUserInfoValue:str];
    
    查询（某个）：
    [LYLDataBaseManager queryUserInfoInDataBase:kTempDataBaseName WithUserID:@"001" andUserInfoField:kUserInfoField];
    
    删除某个：
    [SJUserInfoManager deleteUserInfoInDataBase:kTempDataBaseName WithUserID:@"001"];
    
    查询所有：
    [LYLDataBaseManager queryUserInfosInDataBase:kTempDataBaseName andUserInfoField:kUserInfoField];
