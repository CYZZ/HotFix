//
//  ViewController.m
//  MyUNSDKDemo
//
//  Created by chiyz on 2019/8/12.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import "ViewController.h"
#import <MyUNSDK/MyUNSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)buttonClick:(UIButton *)sender {
	MyUNSDK *unSDK = [[MyUNSDK alloc] init];
	[unSDK pushTestVC];
}
- (IBAction)loadButtonClick:(UIButton *)sender {
	NSString *libraryName = @"PayFix.framework";
	NSString *libPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:libraryName];
	BOOL libExists = [[NSFileManager defaultManager] fileExistsAtPath:libPath];
	if (libExists == YES) {
		NSLog(@"存在动态库正在加载");
		NSBundle *sdkBundle = [NSBundle bundleWithPath:libPath];
		BOOL success = [sdkBundle load];
		NSLog(@"loadSuccess=%d",success);
		BOOL isLoaded = [sdkBundle isLoaded];
		NSLog(@"isLoaded = %d",isLoaded);
	} else {
		NSLog(@"动态库不存在");
	}
}


@end
