#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZKAliPay.h"
#import "ZKPayMediator+AliPay.h"
#import "ZKPayMediator.h"
#import "ZKPayMediatorDefine.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ZKPayMediator+WXPay.h"
#import "ZKWXPay.h"

FOUNDATION_EXPORT double ZKPayMediatorVersionNumber;
FOUNDATION_EXPORT const unsigned char ZKPayMediatorVersionString[];

