//
//  GGNTConfiguration.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#ifndef GGNetwoking_GGNTConfiguration_h
#define GGNetwoking_GGNTConfiguration_h

//#define IS_OFF_LINE


#ifdef IS_OFF_LINE
#define HOTYQ_JAVA_API @"https://121.201.63.217:8089/api/0106/"
#else
#define HOTYQ_JAVA_API @"https://www.hotyq.com:8099/api/0106/"          //线上接口
#endif



static NSTimeInterval GGNetworkTimeoutInterval   = 60;    // 超时时间
static NSTimeInterval kGGCacheOutdateTimeSeconds = 300;   // 5分钟的cache过期时间
static NSUInteger     kGGCacheCountLimit         = 1000;  // 最多1000条cache


typedef NS_ENUM(NSInteger, GGResponseErrCodeType){
    GGServiceResponseErrCodeTypeNone = 1000,     //服务端返回错误代码
    GGServiceResponseErrCodeTypeSeverErr = 500,
};

typedef NS_ENUM(NSUInteger, GGURLResponseStatus){
    GGURLResponseStatusSuccess,       //请求是否成功只考虑是否成功收到服务器反馈。
    GGURLResponseStatusErrorTimeout,
    GGURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};



typedef void (^GGRequestCallbackBlock)(BOOL result, GGResponseErrCodeType errCode, id responseData);
typedef void (^GGRequestTimeoutBlock)(NSInteger errCode, NSString *localizedDescription);




#endif
