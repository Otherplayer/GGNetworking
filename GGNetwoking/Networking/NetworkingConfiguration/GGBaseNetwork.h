//
//  GGBaseNetwork.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "GGNTConfiguration.h"
extern NSString *const kIMGKey;




@interface GGBaseNetwork : AFHTTPRequestOperationManager
+ (instancetype)sharedNetwork;

- (void)POST:(NSString *)URLString params:(id)parameters cache:(BOOL)flag completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;

- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;

- (void)GET:(NSString *)URLString params:(id)parameters cache:(BOOL)flag completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;


@end
