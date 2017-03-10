//
//  ZKPayMediator+AliPay.h
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKPayMediator.h"
#import "ZKPayMediatorDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKPayMediator (AliPay)

/*!
 *	@brief	直接调用AliPaySDK 发起支付
 *	@param 	param 	订单信息
 *	@param 	scheme 	当前应用注册的scheme
 */
- (void)scheduleAliPayOrder:(nonnull NSDictionary *)param scheme:(nonnull NSString *)scheme completionHandler:(void(^)(ZKResponseStatus status, NSError *error))completion;

/*!
 *	@brief	支付宝返回处理
 */
- (void)handleOpenURLForAliPay:(nonnull NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
