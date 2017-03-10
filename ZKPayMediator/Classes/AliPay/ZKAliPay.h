//
//  ZKAliPay.h
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import <Foundation/Foundation.h>

@interface ZKAliPay : NSObject

/*!
 *	@brief	发起支付
 */
- (void)scheduleOrder:(NSDictionary *)param;

/*!
 *	@brief	处理支付宝处理结果
 *	@param 	param 	@{@"URL": NSURLObject}
 */
- (void)hanleOpenURL:(NSDictionary *)param;


@end
