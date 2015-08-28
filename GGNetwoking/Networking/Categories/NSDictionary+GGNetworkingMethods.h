//
//  NSDictionary+GGNetworkingMethods.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/28.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GGNetworkingMethods)
- (NSString *)urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)jsonString;
- (NSArray *)transformedUrlParamsArraySignature:(BOOL)isForSignature;
@end
