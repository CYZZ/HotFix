//
//  MyUNSDK.m
//  MyUNSDK
//
//  Created by chiyz on 2019/8/12.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import "MyUNSDK.h"
#import "MyFirstVC.h"

@implementation MyUNSDK

- (void)pushTestVC {
	
	UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
	MyFirstVC *firstVC = [[MyFirstVC alloc] init];
	if ([controller isKindOfClass:[UINavigationController class]]) {
		[(UINavigationController *)controller pushViewController:firstVC animated:YES];
	} else {
		[controller.navigationController pushViewController:firstVC animated:YES];
	}
	
}

@end
