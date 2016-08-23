# iPhoneUUID

获取iPhone的唯一标识符

NSString * strUUID = (NSString *)[SPIMyUUID load:@"KEY_USERNAME_PASSWORD"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
    }
    
    NSLog(@"%@",strUUID);
