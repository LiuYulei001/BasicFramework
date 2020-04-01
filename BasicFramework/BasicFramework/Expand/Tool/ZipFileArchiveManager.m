//
//  ZipFileArchiveManager.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//


#import "ZipFileArchiveManager.h"
#import "SSZipArchive.h"

@implementation ZipFileArchiveManager


+(BOOL)zipPressedFileAtZipPath:(NSString *)zipPath
                      dataPath:(NSString *)dataPath
{
    return [SSZipArchive createZipFileAtPath:zipPath withContentsOfDirectory:dataPath];
}
+(BOOL)unzipPressedAtdataPath:(NSString *)dataPath
                      zipPath:(NSString *)zipPath
                    deleteZip:(BOOL)deleteZip
{
    
    BOOL success = [SSZipArchive unzipFileAtPath:zipPath toDestination:dataPath];
    if (success && deleteZip) {
        
        [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
    }
    return success;
}



@end
