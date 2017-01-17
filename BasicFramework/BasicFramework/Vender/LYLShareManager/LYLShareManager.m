//
//  LYLShareManager.m
//  ShareDemo
//
//  Created by Rainy on 2017/1/12.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLShareManager.h"

@implementation LYLShareManager

+(BOOL)handleOpenURL:(NSURL *)URL
{
    return [[UMSocialManager defaultManager] handleOpenURL:URL];
}
+(void)openLog:(BOOL)isOpen
{
    [[UMSocialManager defaultManager] openLog:isOpen];
}
+(void)setUmSocialAppkey:(NSString *)UmSocialAppkey
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmSocialAppkey];
}
+(BOOL)setPlatform:(UMSocialPlatformType)platform appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL
{
    return [[UMSocialManager defaultManager] setPlaform:platform appKey:appKey appSecret:appSecret redirectURL:redirectURL];
}


+(void)shareGraphicToPlatformType:(UMSocialPlatformType)platformType
               ContentText:(NSString *)ContentText
                 thumbnail:(id)thumbnail
                shareImage:(id)shareImage
                   success:(success)success
                   failure:(failure)failure
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    ContentText ? (messageObject.text = ContentText) : nil;
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.thumbImage = thumbnail;
    [shareObject setShareImage:shareImage];
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            failure(error);
        }else{
            success(data);
        }
    }];
}
+(void)shareMultimediaToPlatformType:(UMSocialPlatformType)platformType
          ShareContentType:(ShareContentType)ShareContentType
                     title:(NSString *)title
        contentDescription:(NSString *)contentDescription
                 thumbnail:(id)thumbnail
                       url:(NSString *)url
                 StreamUrl:(NSString *)StreamUrl
                   success:(success)success
                   failure:(failure)failure
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    switch (ShareContentType) {
        case ShareContentTypeWeb:{
            
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
            shareObject.webpageUrl = url;
            messageObject.shareObject = shareObject;
        }
            break;
        case ShareContentTypeMusic:{
            
            UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
            shareObject.musicUrl = url;
            shareObject.musicDataUrl = StreamUrl;
            messageObject.shareObject = shareObject;
        }
            break;
        case ShareContentTypeVideo:{
            
            UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
            shareObject.videoUrl = url;
            shareObject.videoStreamUrl = StreamUrl;
            messageObject.shareObject = shareObject;
        }
            break;
        default:
            break;
    }
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            failure(error);
        }else{
            success(data);
        }
    }];
}

@end
