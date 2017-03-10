//
//  ZKPayMediator+AliPay.m
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKPayMediator+AliPay.h"
#import <AlipaySDK/AlipaySDK.h>

NSString *const ZKPayMediatorTargetAliPay   = @"ZKAliPay";

@implementation ZKPayMediator (AliPay)

- (void)scheduleAliPayOrder:(NSDictionary *)param scheme:(nonnull NSString *)scheme completionHandler:(void(^)(ZKResponseStatus status, NSError *error))completion {
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    [paramsToSend setObject:scheme forKey:@"scheme"];
    [paramsToSend addEntriesFromDictionary:param];
    
    if (completion) {
        paramsToSend[@"completion"] = completion;
    }
    
    [self performTarget:ZKPayMediatorTargetAliPay
                 action:@"scheduleOrder:"
                 params:paramsToSend
      shouldCacheTarget:YES];
}

- (void)handleOpenURLForAliPay:(NSURL *)URL {
    [self performTarget:ZKPayMediatorTargetAliPay
                 action:@"hanleOpenURL:"
                 params:@{@"URL": URL}
      shouldCacheTarget:NO];
    [self releaseCachedTargetWithTargetName:ZKPayMediatorTargetAliPay];
}

@end
