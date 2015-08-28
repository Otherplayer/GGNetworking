//
//  GGNetworkManager.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGNetworkManager.h"
#import "GGNTConfiguration.h"

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * API URL 调用参数
 */

#define BASE_URL_Recruit @"recruit/"


NSString *const kTopType = HOTYQ_JAVA_API BASE_URL_Recruit @"getTypes.do?";
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

- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    [self POST:kTopType parameters:parameters completedHandler:completed timeout:timeoutBlock];
}







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


- (void)POST:(NSString *)URLString parameters:(id)Parameters completedHandler:(GGRequestCallbackBlock)Completed timeout:(GGRequestTimeoutBlock)TimeoutBlock{
    [[GGBaseNetwork sharedNetwork] POST:URLString params:Parameters cache:YES completed:Completed timeout:TimeoutBlock];
}


@end
