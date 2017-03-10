//
//  ZKPayMediator+WXPay.m
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKPayMediator+WXPay.h"

NSString *const ZKPayMediatorTargetWX   = @"ZKWXPay";

@implementation ZKPayMediator (WXPay)

- (BOOL)scheduleWXPayOrder:(NSDictionary *)params completionHandler:(void(^)(ZKResponseStatus status, NSError *error))completion {
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    [paramsToSend addEntriesFromDictionary:params];
    
    if (completion) {
        paramsToSend[@"completion"] = completion;
    }
    
    NSNumber *returnValue = [self performTarget:ZKPayMediatorTargetWX
                                         action:@"scheduleOrder:"
                                         params:paramsToSend
                              shouldCacheTarget:YES];
    
    return returnValue.boolValue;
}

- (BOOL)handleOpenURLForWXPay:(NSURL *)URL {
    NSNumber *returnValue = [self performTarget:ZKPayMediatorTargetWX
                                         action:@"hanleOpenURL:" params:@{@"URL": URL}
                              shouldCacheTarget:NO];
    [self releaseCachedTargetWithTargetName:ZKPayMediatorTargetWX];
    return returnValue.boolValue;
}

@end
