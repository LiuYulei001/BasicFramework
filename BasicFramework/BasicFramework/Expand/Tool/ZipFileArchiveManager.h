//
//  ZipFileArchiveManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface ZipFileArchiveManager : NSObject



/**
 *  压缩文件
 *
 *  @param zipPath       目标文件路径
 *  @param dataPath      资源文件路径
 *
 */
+(BOOL)zipPressedFileAtZipPath:(NSString *)zipPath
                      dataPath:(NSString *)dataPath;
/**
 *  解压文件
 *
 *  @param dataPath      目标文件路径
 *  @param zipPath       资源文件路径
 *
 */
+(BOOL)unzipPressedAtdataPath:(NSString *)dataPath
                      zipPath:(NSString *)zipPath
                    deleteZip:(BOOL)deleteZip;


@end
