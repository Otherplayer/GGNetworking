//
//  GGTopDataSource.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGTopDataSource.h"
#import "GGNTManager.h"

@interface GGTopDataSource ()
@property (nonatomic, strong)GGNTManager *manager;
@end

@implementation GGTopDataSource

-(GGNTManager *)manager{
    if (!_manager) {
        _manager = [[GGNTManager alloc] init];
    }
    return _manager;
}

- (void)loadData{
    
    
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    [paramsDictionary setValue:@"55BDF2C7-E5EE-418F-8619-84C93A00528A" forKey:@"app_id"];
    [paramsDictionary setValue:@"红演圈" forKey:@"app_name"];
    [paramsDictionary setValue:@"ios" forKey:@"app_os"];
    [paramsDictionary setValue:@"8.3" forKey:@"app_os_ver"];
    [paramsDictionary setValue:@"5e88fe918732863d8f4ef1cfe6e657d8" forKey:@"app_token"];
    [paramsDictionary setValue:@"iPhone Simulator" forKey:@"app_type"];
    [paramsDictionary setValue:@"" forKey:@"app_umeng"];
    [paramsDictionary setValue:@"55BDF2C7-E5EE-418F-8619-84C93A00528A" forKey:@"mark"];
    [paramsDictionary setValue:@"110593" forKey:@"uid"];
    [paramsDictionary setValue:@"get_main_info" forKey:@"action"];
    
    [self.manager getTopTypesWithParameters:paramsDictionary completedHandler:^(BOOL result, GGResponseErrCodeType errCode, id responseData) {
        NSLog(@"%@",responseData);
    } timeout:^(NSInteger errCode, NSString *localizedDescription) {
        
    }];
    
}

- (void)loadDynamic{
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    
    [paramsDictionary setObject:@"112478" forKey:@"d_uid"];
    [paramsDictionary setObject:@"1" forKey:@"page"];
    [paramsDictionary setObject:@(12) forKey:@"size"];
    [paramsDictionary setObject:@"4C648A69-E29D-4465-8677-3B9D90178333" forKey:@"app_id"];
    [paramsDictionary setObject:@"红演圈" forKey:@"app_name"];
    [paramsDictionary setObject:@"ios" forKey:@"app_os"];
    [paramsDictionary setObject:@"8.4" forKey:@"app_os_ver"];
    [paramsDictionary setObject:@"7f891ce8b443674fc1dc70dd8a093496" forKey:@"app_token"];
    [paramsDictionary setObject:@"iPhone Simulator" forKey:@"app_type"];
    [paramsDictionary setObject:@"1.24" forKey:@"app_ver"];
    [paramsDictionary setObject:@"112478" forKey:@"uid"];
    [paramsDictionary setObject:@"" forKey:@"app_umeng"];
    [paramsDictionary setObject:@"4C648A69-E29D-4465-8677-3B9D90178333" forKey:@"mark"];
    [[GGNTManager sharedManager] getDynamicListWithParameters:paramsDictionary completedHandler:^(BOOL result, GGResponseErrCodeType errCode, id responseData) {
        
    } timeout:^(NSInteger errCode, NSString *localizedDescription) {
        
    }];
}

@end
