<h1 align="center">
ZKPayMediator  
<h5 align="center", style="color, #666">
集成了支付宝支付和微信支付
</h5>
</h1>
<p align="center">
<img src="https://img.shields.io/badge/pod-v0.1.0-blue.svg" />
<img src="https://img.shields.io/badge/supporting-objectiveC-yellow.svg" />
<img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" />
<img src="https://img.shields.io/cocoapods/p/ZKPayMediator.svg?style=flat" />
</p>
<br>
<br>

## Example

```Objc
//微信支付，服务端下发（这个信息有可能已经失效，微信要用真机测试）
    NSDictionary *param = @{@"appId":@"wx681a54f7179c96d0",
                            @"nonceStr":@"eIQjpuJDlvw8GHYk",
                            @"packageValue":@"Sign=WXPay",
                            @"partnerId":@"1319759701",
                            @"prepayId":@"wx2016051615152302129e26f00887287136",
                            @"sign":@"1D38273765BF155DE0685D23EF73940C",
                            @"timeStamp":@"1463382923"};
    [[ZKPayMediator sharedInstance] scheduleWXPayOrder:param completionHandler:^(ZKResponseStatus status, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:(status == ZKResponseStatusSuccess ? @"支付成功" : error.description)
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
```
    
```Objc
     //支付宝支付，服务端下发 （这个信息有可能已经失效）
    NSString *sign = @"app_id=2015052600090779&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.02%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22314VYGIAGG7ZOYY%22%7D&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA2&timestamp=2016-08-15%2012%3A12%3A15&version=1.0&sign=MsbylYkCzlfYLy9PeRwUUIg9nZPeN9SfXPNavUCroGKR5Kqvx0nEnd3eRmKxJuthNUx4ERCXe552EV9PfwexqW%2B1wbKOdYtDIb4%2B7PL3Pc94RZL0zKaWcaY3tSL89%2FuAVUsQuFqEJdhIukuKygrXucvejOUgTCfoUdwTi7z%2BZzQ%3D";
    [[ZKPayMediator sharedInstance] scheduleAliPayOrder:@{@"sign": sign} scheme:@"test" completionHandler:^(ZKResponseStatus status, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:(status == ZKResponseStatusSuccess ? @"支付成功" : error.description)
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
```

```Objc
// 回调处理
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[ZKPayMediator sharedInstance] handleOpenURLForAliPay:url];
    } else if ([url.host isEqualToString:@"pay"]) {
        [[ZKPayMediator sharedInstance] handleOpenURLForWXPay:url];
    }
    return YES;
}
```

## Requirements
WechatSDK v1.7.5
<br>
Alipay v15.2.0


## Installation

ZKPayMediator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZKPayMediator'

单独支持微信或者支付宝
pod 'ZKPayMediator', :subspecs => ['WXPay']
pod 'ZKPayMediator', :subspecs => ['AliPay']
```

## Author

Kaiser, deyang143@126.com

## License

ZKPayMediator is available under the MIT license. See the LICENSE file for more info.


