//
//  ZKAliPay.m
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKAliPay.h"
#import "ZKPayMediatorDefine.h"
#import <AlipaySDK/AlipaySDK.h>
#import <objc/runtime.h>

@interface ZKAliPay ()

@property (nonatomic, readwrite) NSDictionary *params;

@end

@implementation ZKAliPay

#pragma mark - public methods

- (void)scheduleOrder:(NSDictionary *)param {
    NSURL *URL = [NSURL URLWithString:@"alipay://"];
    if (![[UIApplication sharedApplication] canOpenURL:URL]) {
        void(^completionHandler)(ZKResponseStatus status, NSError *error) = self.params[@"completion"];
        if (completionHandler) {
            completionHandler(ZKResponseStatusError, [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorUnsupport userInfo:nil]);
        }
        
        return;
    }
    
    NSString *sign = param[@"sign"];
    void(^completionHandler)(ZKResponseStatus, NSError *) = param[@"completion"];
    if (!sign) {
        if (completionHandler) {
            NSError *error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorAuthDeny userInfo:nil];
            completionHandler(ZKResponseStatusError, error);
        }
        return;
    }
    
    self.params = param;
    __weak __typeof(self) weakSelf = self;
    [[AlipaySDK defaultService] payOrder:sign fromScheme:param[@"scheme"] callback:^(NSDictionary *resultDic) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return ;
        
        [strongSelf _callbackResponseHanler:resultDic];
    }];
}

- (void)hanleOpenURL:(NSDictionary *)param {
    __weak __typeof(self) weakSelf = self;
    
    [[AlipaySDK defaultService] processOrderWithPaymentResult:param[@"URL"]
                                              standbyCallback:^(NSDictionary *resultDic) {
                                                  __strong __typeof(weakSelf) strongSelf = weakSelf;
                                                  if (!strongSelf) return ;
                                                  
                                                  [strongSelf _callbackResponseHanler:resultDic];
                                              }];
}

#pragma mark - private methods

- (void)_callbackResponseHanler:(NSDictionary *)info {
    void(^completionHandler)(ZKResponseStatus, NSError *) = self.params[@"completion"];
    
    NSInteger errorCode = [info[@"resultStatus"] integerValue];
    NSDictionary *userInfo;
    ZKPayError err = ZKPayErrorUnknow;
    switch (errorCode) {
        case 9000: {
            userInfo = @{ZKPayErrorMsgKey: @"支付宝支付成功"};
        }
            break;
        case 6001: {
            userInfo = @{ZKPayErrorMsgKey: @"支付宝支付取消"};
            err = ZKPayErrorUserCancel;
        }
            break;
        case 8000: {
            userInfo = @{ZKPayErrorMsgKey: @"支付宝支付结果确认中"};
        }
            break;
        default: {
            userInfo = @{ZKPayErrorMsgKey: @"支付宝支付失败"};
            err = ZKPayErrorCommon;
        }
            break;
    }
    
    if (completionHandler) {
        NSError *error = [NSError errorWithDomain:ZKPayErrorDomain code:err userInfo:userInfo];
        completionHandler(error.code == 9000 ? ZKResponseStatusSuccess : ZKResponseStatusError , error);
    }
}

#pragma mark - getters and setters

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @selector(params));
}

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @selector(params), params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
