//
//  ZKWXPay.m
//  Pods
//
//  Created by Kaiser on 2017/3/10.
//
//

#import "ZKWXPay.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ZKPayMediatorDefine.h"
#import <objc/runtime.h>

@interface ZKWXPay () <WXApiDelegate>

@property (nonatomic, readwrite) NSDictionary *params;

@end

@implementation ZKWXPay

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

#pragma mark - WXApiDelegate

- (void)onReq:(BaseReq *)req {
    
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        
    } else if([resp isKindOfClass:[PayResp class]]){
        // 支付返回结果，实际支付结果需要去微信服务器端查询
        void(^completionHandler)(ZKResponseStatus status, NSError *error) = self.params[@"completion"];
        if (completionHandler) {
            completionHandler(resp.errCode == WXSuccess ? ZKResponseStatusSuccess : ZKResponseStatusError,
                              [self errorWithCode:resp.errCode]);
        }
    }
}

- (NSError *)errorWithCode:(int)code {
    NSError *error;
    switch (code) {
        case WXSuccess:
            break;
        case WXErrCodeCommon: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorCommon userInfo:nil];
        }
            break;
        case WXErrCodeUserCancel: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorUserCancel userInfo:nil];
        }
            break;
        case WXErrCodeSentFail: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorSentFail userInfo:nil];
        }
            break;
        case WXErrCodeAuthDeny: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorAuthDeny userInfo:nil];
        }
            break;
        case WXErrCodeUnsupport: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorUnsupport userInfo:nil];
        }
            break;
            
        default: {
            error = [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorUnknow userInfo:nil];
        }
            break;
    }
    
    return error;
}

#pragma mark - public methods

- (NSNumber *)scheduleOrder:(NSDictionary *)param {
    void(^completionHandler)(ZKResponseStatus status, NSError *error) = param[@"completion"];
    BOOL returnBool = [self _isWXAppInstalled];
    if (!returnBool) {
        if (completionHandler) {
            completionHandler(ZKResponseStatusError, [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorUnsupport userInfo:nil]);
        }
        
        return @NO;
    }
    
    
    NSString *appId = param[@"appId"];
    if (!appId || [appId isEqual:[NSNull null]] || appId.length == 0) {
        if (completionHandler) {
            completionHandler(ZKResponseStatusError, [NSError errorWithDomain:ZKPayErrorDomain code:ZKPayErrorInfomationLoss userInfo:nil]);
        }
        
        return @NO;
    }
    
    self.params = param;
    
    [WXApi registerApp:appId];
    
    PayReq *request = [[PayReq alloc] init];
    request.openID = param[@"appId"];
    request.partnerId = param[@"partnerId"];
    request.prepayId = param[@"prepayId"];
    request.nonceStr = param[@"nonceStr"];
    request.timeStamp = param[@"timeStamp"] ? (UInt32)[param[@"timeStamp"] integerValue] : 0;
    request.package = param[@"packageValue"];
    request.sign = param[@"sign"];
    
    return @([WXApi sendReq:request]);
}

- (NSNumber *)hanleOpenURL:(NSDictionary *)param {
    BOOL returnBool = [WXApi handleOpenURL:param[@"URL"] delegate:self];
    return @(returnBool);
}

- (BOOL)_isWXAppInstalled {
    NSURL *URL = [NSURL URLWithString:@"weixin://"];
    return  [[UIApplication sharedApplication] canOpenURL:URL];
}

#pragma mark - getters and setters

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @selector(params));
}

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, @selector(params), params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
