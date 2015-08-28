//
//  GGNetworkManager.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGNTConfiguration.h"

@interface GGNetworkManager : NSObject

+ (instancetype)sharedManager;

/// 获取类型数据
- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;




@end
