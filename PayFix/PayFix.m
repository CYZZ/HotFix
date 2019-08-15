//
//  PayFix.m
//  PayFix
//
//  Created by chiyz on 2019/8/12.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import "PayFix.h"
#import <UIKit/UIKit.h>

@implementation PayFix

- (void)startShowAlerView {
	UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
	
	UINavigationController *Nav = (UINavigationController *)rootViewController;
	
//	Nav.visibleViewController
	UIAlertController *alercontroller = [UIAlertController alertControllerWithTitle:@"热更新"
																			message:@"我是渣渣辉，船新版本油腻的世界"
																	 preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
													  style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * _Nonnull action) {
														NSLog(@"确定func=%s",__func__);
													}];
	
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
													  style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * _Nonnull action) {
														NSLog(@"取消func=%s",__func__);
													}];
	[alercontroller addAction:action1];
	[alercontroller addAction:cancel];
	
	[Nav.visibleViewController presentViewController:alercontroller
											animated:YES
										  completion:^{
											  
										  }];
	
}

@end
