//
//  MyPay.m
//  MyUNSDK
//
//  Created by chiyz on 2019/8/15.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import "MyPay.h"
#import <UIKit/UIKit.h>

@implementation MyPay

+ (void)weixinpay {
	UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"支付" message:@"进行weixinPay" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
													  style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * _Nonnull action) {
														NSLog(@"点击了确定按钮");
													}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
													 style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction * _Nonnull action) {
													   NSLog(@"点击了取消按钮");
												   }];
	[alerController addAction:action1];
	[alerController addAction:cancel];
	
	UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
	
	if ([rootController isKindOfClass:[UINavigationController class]]) {
		[[(UINavigationController *)rootController visibleViewController] presentViewController:alerController animated:YES completion:^{
			
		}];
	} else {
		[rootController presentViewController:alerController animated:YES completion:^{
			
		}];
	}
}
/// 测试支付宝的对象方法
- (void)alipay:(NSArray *)arr isShow:(BOOL)isShow{
	UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"支付" message:@"进行Alipay" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
													  style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * _Nonnull action) {
														NSLog(@"点击了Alipay确定按钮");
													}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
													 style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction * _Nonnull action) {
													   NSLog(@"点击了Alipay取消按钮");
												   }];
	[alerController addAction:action1];
	[alerController addAction:cancel];
	
	UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
	
	if ([rootController isKindOfClass:[UINavigationController class]]) {
		[[(UINavigationController *)rootController visibleViewController] presentViewController:alerController animated:YES completion:^{
			
		}];
	} else {
		[rootController presentViewController:alerController animated:YES completion:^{
			
		}];
	}
	
}


@end
