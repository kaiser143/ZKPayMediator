//
//  ZKPayMediator+WXPay.h
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKPayMediator.h"
#import "ZKPayMediatorDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKPayMediator (WXPay)

/*!
 *	@brief	发起微信支付
 *	@param 	params 	订单信息
 *	@return	成功返回YES，失败返回NO。
 */
- (BOOL)scheduleWXPayOrder:(nonnull NSDictionary *)params completionHandler:(void(^)(ZKResponseStatus status, NSError *error))completion;

/*!
 *	@brief	微信支付结果处理
 *	@return	成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURLForWXPay:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
