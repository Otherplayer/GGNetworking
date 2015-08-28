//
//  GGNetworkManager.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGBaseNetwork.h"

@interface GGNetworkManager : NSObject

+ (instancetype)sharedManager;


- (void)getTopTypesWithParameters:(NSDictionary *)parameters completedHandler:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock;




@end
