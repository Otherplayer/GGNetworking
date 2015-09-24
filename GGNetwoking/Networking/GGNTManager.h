//
//  GGNTManager.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/28.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGBaseNetwork.h"
#import <JSONModel.h>

@interface GGNTManager : GGBaseNetwork

+ (instancetype)sharedManager;

/// 获取一级类型列表
- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;

/// 获取动态
- (void)getDynamicListWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;

@end
