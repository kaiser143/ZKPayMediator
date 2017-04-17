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

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
WechatSDK v1.7.5
Alipay v15.2.0


## Installation

ZKPayMediator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZKPayMediator"

单独支持微信或者支付宝
pod "ZKPayMediator", :subspecs => ['WXPay']
pod "ZKPayMediator", :subspecs => ['AliPay']

或者一起支持
pod "ZKPayMediator", :subspecs => ['WXPay', 'AliPay']
```

## Author

Kaiser, deyang143@126.com

## License

ZKPayMediator is available under the MIT license. See the LICENSE file for more info.
