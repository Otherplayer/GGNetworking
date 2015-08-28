//
//  GGBaseNetwork.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGBaseNetwork.h"
#import "GGURLResponse.h"
#import "GGLogger.h"
#import "GGCache.h"

NSString *const kIMGKey = @"kIMGKey";

@interface GGBaseNetwork ()
@property (nonatomic, strong)GGCache *cache;
@property (nonatomic, strong)NSMutableDictionary *dispatchList; //请求列表
@property (nonatomic, strong)GGBaseNetwork *shareManager;
@end

@implementation GGBaseNetwork
#pragma mark - lifecircle
+ (instancetype)sharedNetwork {
    static GGBaseNetwork *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[GGBaseNetwork manager];
        shareManager.responseSerializer.acceptableContentTypes = [shareManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        shareManager.responseSerializer.acceptableContentTypes = [shareManager.responseSerializer.acceptableContentTypes setByAddingObject:@"image/jpeg"];
        shareManager.securityPolicy.allowInvalidCertificates = YES;//安全请求
        [shareManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        shareManager.requestSerializer.timeoutInterval = GGNetworkTimeoutInterval;
        [shareManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    });
    return shareManager;
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - getter and setter

- (NSMutableDictionary *)dispatchList{
    if (_dispatchList == nil) {
        _dispatchList = [[NSMutableDictionary alloc] init];
    }
    return _dispatchList;
}

- (GGCache *)cache{
    if (_cache == nil) {
        _cache = [GGCache sharedInstance];
    }
    return _cache;
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -  统一数据处理 Private

////数据处理，请勿改动

- (void)isSuccessedOnCallingAPI:(GGURLResponse *)response shouldCache:(BOOL)flag completedHandler:(GGRequestCallbackBlock)completed{
    
    id fetchedRawData = nil;
    
    if (response.responseObject) {
        fetchedRawData = [response.responseObject copy];
    } else {
        fetchedRawData = [response.responseData copy];
    }
    
    if (flag && !response.isCache) {
        [self.cache saveCacheWithData:response.responseData URLStr:response.requestUrlStr params:response.requestParams];
    }
    
    [GGLogger logDebugResponse:response];
    
    [self fetchData:fetchedRawData completedHandler:completed];

}

- (void)isFailedOncallingAPIOperation:(AFHTTPRequestOperation *)operation withError:(NSError *)error completedHandler:(GGRequestCallbackBlock)completed timeoutHandler:(GGRequestTimeoutBlock)timeoutBlock{
    
    [GGLogger logDebugOperation:operation];
    
    if (error.code == NSURLErrorTimedOut) {
        timeoutBlock(error.code,error.localizedDescription);
    }else{
    }
    completed(NO, GGServiceResponseErrCodeTypeSeverErr, error.localizedDescription);
}

- (void)isSuccessOperation:(AFHTTPRequestOperation *)operation withReObject:(id)responseObject completedHandler:(GGRequestCallbackBlock)completed{
    
    [GGLogger logDebugOperation:operation];
    
    [self fetchData:responseObject completedHandler:completed];
}


- (void)fetchData:(id)object completedHandler:(GGRequestCallbackBlock)completed{
    GGResponseErrCodeType reponseCode = [object[@"state_code"] intValue];
    id resultData = object[@"data"];
    completed(reponseCode == GGServiceResponseErrCodeTypeNone, reponseCode, resultData);
}


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Base Network Private

////网络请求,请勿改动

- (void)POST:(NSString *)URLString params:(id)parameters cache:(BOOL)flag completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    
    // 先检查一下是否需要从缓存中读数据
    if (flag && [self hasCacheWithURLStr:URLString Params:parameters completedHandler:completed]) {
        return;
    }
    
    [[GGBaseNetwork sharedNetwork] POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessOperation:operation object:responseObject url:URLString params:parameters shouldCache:flag completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOncallingAPIOperation:operation withError:error completedHandler:completed timeoutHandler:timeoutBlock];
        
    }];
}


- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    
    [[GGBaseNetwork sharedNetwork] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < images.count; i++) {
            UIImage *image = [[images objectAtIndex:i] objectForKey:kIMGKey];
            NSString *fileName = [[[NSDate date] description] stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.35);
            [formData appendPartWithFileData:imageData name:serviceName fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessOperation:operation withReObject:responseObject completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOncallingAPIOperation:operation withError:error completedHandler:completed timeoutHandler:timeoutBlock];
        
    }];
}


- (void)GET:(NSString *)URLString params:(id)parameters cache:(BOOL)flag completed:(GGRequestCallbackBlock)completed timeout:(GGRequestTimeoutBlock)timeoutBlock{
    
    // 先检查一下是否需要从缓存中读数据
    if (flag && [self hasCacheWithURLStr:URLString Params:parameters completedHandler:completed]) {
        return;
    }
    
    [[GGBaseNetwork sharedNetwork] GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessOperation:operation object:responseObject url:URLString params:parameters shouldCache:flag completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOncallingAPIOperation:operation withError:error completedHandler:completed timeoutHandler:timeoutBlock];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - private

- (BOOL)hasCacheWithURLStr:(NSString *)urlStr Params:(NSDictionary *)params completedHandler:(GGRequestCallbackBlock)completed{
    
    NSData *result = [self.cache fetchCachedDataWithURLStr:urlStr params:params];
    
    if (result == nil) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        GGURLResponse *response = [[GGURLResponse alloc] initWithData:result];
        response.requestParams = params;
        response.requestUrlStr = urlStr;
        [self isSuccessedOnCallingAPI:response shouldCache:NO completedHandler:completed];
    });
    
    return YES;
}


- (void)isSuccessOperation:(AFHTTPRequestOperation *)operation object:(id)object url:(NSString *)url params:(id)params shouldCache:(BOOL)flag completedHandler:(GGRequestCallbackBlock)completed{
    GGURLResponse *response = [[GGURLResponse alloc] initWithResponse:operation.response
                                                              request:operation.request
                                                       responseObject:object
                                                       responseString:operation.responseString
                                                         responseData:operation.responseData
                                                               status:GGURLResponseStatusSuccess];
    
    response.requestParams = params;
    response.requestUrlStr = url;
    
    [self isSuccessedOnCallingAPI:response shouldCache:flag completedHandler:completed];
}



@end
