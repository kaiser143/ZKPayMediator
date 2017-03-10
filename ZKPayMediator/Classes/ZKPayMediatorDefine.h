//
//  ZKPayMediatorDefine.h
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#ifndef ZKPayMediatorDefine_h
#define ZKPayMediatorDefine_h

static NSString *const ZKPayErrorDomain = @"ZKPayErrorDomain";
static NSString *const ZKPayErrorMsgKey = @"ZKPayErrorMsgKey";

typedef NS_ENUM(NSUInteger, ZKResponseStatus) {
	ZKResponseStatusUnknow      = 0, /**< 未知错误 */
	ZKResponseStatusSuccess     = 1, /**< 成功 */
	ZKResponseStatusError       = 2, /**< 失败 */
};

typedef NS_ENUM(NSUInteger, ZKPayError) {
    ZKPayErrorUnknow        = 99,  /**< 未知错误 */
	ZKPayErrorCommon        = 100, /**< 普通错误类型 */
	ZKPayErrorUserCancel    = 101, /**< 用户点击取消并返回 */
	ZKPayErrorSentFail      = 102, /**< 发送失败 */
	ZKPayErrorAuthDeny      = 103, /**< 授权失败 */
	ZKPayErrorUnsupport     = 104, /**< 不支持 */
    ZKPayErrorInfomationLoss= 105, /**< 信息缺失，如微信传入的参数缺少appId */
};

#endif /* ZKPayMediatorDefine_h */
