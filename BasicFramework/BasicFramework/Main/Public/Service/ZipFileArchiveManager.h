//
//  ZipFileArchiveManager.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/22.
//  Copyright © 2017年 Rainy. All rights reserved.
//

/*===============================================================================
 
 此工具类用于本地集成H5包 ->
 
 1.下载（H5的zip包下载成功后清除缓存并存储）
 2.解压（解压zip包成功后删除zip并存储解压后的文件）
 3.获取（H5包后的入口文件）
 
 ===============================================================================*/

typedef void(^downZipSuccess)(NSString *filePath);
typedef void(^downZipFailure)(NSError *error);

#import <Foundation/Foundation.h>

@interface ZipFileArchiveManager : NSObject

/**
 *  H5的zip包下载、解压、存储
 *
 *  @param UrlString       接口
 *  @param parameters      参数
 *  @param downZipSuccess  成功后返回H5入口路径
 *  @param downZipFailure  下载失败
 *
 */
+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                            Parameters:(NSDictionary *)parameters
                        downZipSuccess:(downZipSuccess)downZipSuccess
                        downZipFailure:(downZipFailure)downZipFailure;
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
                      zipPath:(NSString *)zipPath;

@end
