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
 *  @param isMandatory     是否强制(YES：下载后解压后加载新的H5； NO：下载zip至tempZipfilePath，下次进入程序再解压加载)
 *  @param downZipSuccess  成功后返回H5入口路径
 *  @param downZipFailure  下载失败
 *
 */
+(void)downFileFromServerWithUrlString:(NSString *)UrlString
                            Parameters:(NSDictionary *)parameters
                           isMandatory:(BOOL)isMandatory
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

/**
 *  解压文件至tempUnzipPressedFilePath 解压成功后再删除zip并移动解压后的文件至unzipPressedFilePath
 *
 *  @param zipPath       资源文件路径
 *
 */
+(BOOL)unzipPressedAtzipPath:(NSString *)zipPath;
/**
 *  清理缓存
 */
+(void)clearWebCaches;
/**
 *  清理前文件
 */
+(void)clearOldFile;
/** H5入口文件路径路径 */
+(NSString *)entranceHtmlFilePath;
/** zip解压后最终文件路径路径 */
+(NSString *)unzipPressedFilePath;
/** zip解压后临时文件路径路径 */
+(NSString *)tempUnzipPressedFilePath;
/** 临时文件路径文件路径路径 */
+(NSString *)tempZipfilePath;


@end
