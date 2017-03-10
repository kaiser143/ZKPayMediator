//
//  ZKWXPay.h
//  Pods
//
//  Created by Kaiser on 2017/3/10.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKWXPay : NSObject

/*!
 *	@brief	发起支付
 *	@param 	param 	订单信息
 *	@return	@(YES) or @(NO)
 */
- (NSNumber *)scheduleOrder:(NSDictionary *)param;

/*!
 *	@brief	<#Description#>
 *	@param 	param 	@{@"URL": NSURLObject}
 *	@return	@(YES) or @(NO)
 */
- (NSNumber *)hanleOpenURL:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
