//
//  GGNetworkManager.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGNetworkManager.h"
#import "GGBaseNetwork.h"

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * API URL 调用参数
 */

#define BASE_URL_Recruit @"recruit/"


NSString *const kAPITopType = HOTYQ_JAVA_API BASE_URL_Recruit @"getTypes.do?";
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


@interface GGNetworkManager ()

@end

@implementation GGNetworkManager

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - public interface

///1.
- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    [self POST:kAPITopType params:parameters cache:YES completedHandler:completed timeout:timeoutBlock];
}


///2.




////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - life
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static GGNetworkManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[GGNetworkManager alloc] init];
    });
    return manager;
}


- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

///post 请求
- (void)POST:(NSString *)URLString params:(id)params cache:(BOOL)flag completedHandler:(GGRequestCallbackBlock)Completed timeout:(GGRequestTimeoutBlock)TimeoutBlock{
    [[GGBaseNetwork sharedNetwork] POST:URLString params:params cache:flag completed:Completed timeout:TimeoutBlock];
}

///post 上传图片 (/** 数组images里面数据为dictionary{kIMGKey:image} **/)
- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    [[GGBaseNetwork sharedNetwork] POST:URLString params:parameters images:images imageSConfig:serviceName completed:completed timeout:timeoutBlock];
}

///get 请求
- (void)GET:(NSString *)URLString params:(id)parameters cache:(BOOL)flag completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    [[GGBaseNetwork sharedNetwork] GET:URLString params:parameters cache:flag completed:completed timeout:timeoutBlock];
}



@end
