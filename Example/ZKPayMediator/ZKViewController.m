//
//  ZKViewController.m
//  ZKPayMediator
//
//  Created by Kaiser on 03/09/2017.
//  Copyright (c) 2017 Kaiser. All rights reserved.
//

#import "ZKViewController.h"
#import <ZKPayMediator/ZKPayMediator+WXPay.h>
#import <ZKPayMediator/ZKPayMediator+AliPay.h>

@interface ZKViewController ()

@end

@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxButton setBackgroundColor:[UIColor lightGrayColor]];
    [wxButton addTarget:self action:@selector(didTappedWXButton:) forControlEvents:UIControlEventTouchUpInside];
    [wxButton setFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 50)];
    [wxButton setTitle:@"调用微信支付" forState:UIControlStateNormal];
    [wxButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wxButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [self.view addSubview:wxButton];
    
    UIButton *alipayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [alipayButton setBackgroundColor:[UIColor lightGrayColor]];
    [alipayButton addTarget:self action:@selector(didTappedAlipayButton:) forControlEvents:UIControlEventTouchUpInside];
    [alipayButton setFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 50)];
    [alipayButton setTitle:@"调用支付宝支付" forState:UIControlStateNormal];
    [alipayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alipayButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [self.view addSubview:alipayButton];
}

- (void)didTappedWXButton:(UIButton *)sender {
    //服务端下发（这个信息有可能已经失效，微信要用真机测试）
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
}

- (void)didTappedAlipayButton:(UIButton *)sender {
    //服务端下发 （这个信息有可能已经失效）
    NSString *sign = @"service=\"mobile.securitypay.pay\"&seller_id=\"17773486446@163.com\"&payment_type=\"1\"&partner=\"2088421933747080\"&_input_charset=\"utf-8\"&subject=\"快送\"&total_fee=\"5.00\"&notify_url=\"http://api.kuaisongok.com/pay/notify_url.htm\"&body=\"快送消费\"&it_b_pay=\"15m\"&out_trade_no=\"561492398385108\"&sign=\"2XzAdIGSDLFs2LUgzYDT89Uw033N1f0CPtX1aSPgKrNQ7CQEVJ%2BHLtmI05ZBXepp7IaAjN0%2BCIyac%2BB%2BM%2FAr9fbEaQ9J1smxguEg5uvRQ8yjJ7yCjf8HQmlMWdMMB8RFevIfTHM1miOFxTzM67efCdUuPXoo1nG3%2FIhMYxBeZGI%3D\"&sign_type=\"RSA\"";
    [[ZKPayMediator sharedInstance] scheduleAliPayOrder:@{@"sign": sign} scheme:@"test" completionHandler:^(ZKResponseStatus status, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:(status == ZKResponseStatusSuccess ? @"支付成功" : error.description)
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}


@end
