//
//  MyFirstVC.m
//  MyUNSDK
//
//  Created by chiyz on 2019/8/12.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import "MyFirstVC.h"
#import <AFNetworking/AFNetworking.h>
#import <SSZipArchive.h>
#import "JSPatch/JPEngine.h"

@interface MyFirstVC ()<UITableViewDataSource, UITableViewDelegate,SSZipArchiveDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString *> *dataArr;

@end

@implementation MyFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
//	[self starJSLoad];
	
	[self setupView];
	
	self.dataArr = @[
					 @"弹窗",
					 @"加载沙盒动态库",
					 @"读取沙盒文件",
					 @"下载文件",
					 @"删除文件",
					 @"执行动态库的方法",
					 @"分割线---以下JSPath测试",
					 @"下载JS文件",
					 @"执行JSPath更新"
					 ];
}

- (void) starJSLoad {
	[JPEngine startEngine];
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"unDemo" ofType:@"js"];
	NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
	[JPEngine evaluateScript:script];
}

/// 初始化View
- (void)setupView {
	[self.view addSubview:self.tableView];
	// 注册cell
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	cell.textLabel.text = self.dataArr[indexPath.row];
	if (indexPath.row == 6) {
		cell.backgroundColor = [UIColor orangeColor];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger row = indexPath.row;
//	NSString *text = self.dataArr[row];
	
	if (row == 0) {
		[self presenAlerView];
	} else if (row == 1) {
		[self loadDylib];
	} else if (row == 2) {
		// 读取文件
		[self readCacheFiles];
	} else if (row == 3) {
		// 下载文件
		[self startDownloadFile];
	} else if (row == 4) {
		// 删除文件
		[self deleteFile];
	} else if (row == 5) {
		// 执行动态库方法
		[self startActDylibMethod];
	} else if (row == 6) {
		//分割线，不需要执行
	} else if (row == 7) {
		// 下载js文件
		[self startDownloadJSFile];
	} else if (row == 8) {
		// 开始执行js更新
		[self startLoadCacheJSFile];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
// 弹出页面
- (void)presenAlerView {
	UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"测试1" message:@"测试是否被调用" preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
													  style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * _Nonnull action) {
														NSLog(@"点击了确定按钮");
//														[self testLogMessage];
													}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
													 style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction * _Nonnull action) {
													   NSLog(@"点击了取消按钮");
												   }];
	[alerController addAction:action1];
	[alerController addAction:cancel];
	
	[self presentViewController:alerController animated:YES completion:^{
		
	}];
}
/// 测试打印
- (void)testLogMessage {
//	slf.testLogMessage
	NSLog(@"我被点击确定之后调用的方法");
}

- (void)cancelClick {
	NSLog(@"点击了取消按钮,fun=%s",__func__);
}

- (void)alerComple {
	NSLog(@"已经弹出成功");
}

/// 开始从沙盒中读取
- (void)loadDylib {
	NSString *cachePath = [self getCacheFilePath];
//	NSString *dylibPath = [cachePath stringByAppendingPathComponent:@"PayFix.framework"];
	
	
	NSString *libraryName = @"PayFix.framework";
	NSString *libPath = [cachePath stringByAppendingPathComponent:libraryName];;
	BOOL libExists = [[NSFileManager defaultManager] fileExistsAtPath:libPath];
	if (libExists == YES) {
		NSLog(@"动态库位置=%@",libPath);
		NSLog(@"存在动态库正在加载");
		NSBundle *sdkBundle = [NSBundle bundleWithPath:libPath];
		BOOL success = [sdkBundle load];
		NSLog(@"loadSuccess=%d",success);
		BOOL isLoaded = [sdkBundle isLoaded];
		NSLog(@"isLoaded = %d",isLoaded);
	} else {
		NSLog(@"动态库不存在");
	}
	
//	NSBundle *dylibBundle = [NSBundle bundleWithPath:dylibPath];
//	BOOL loadSuccess = [dylibBundle load];
//	NSLog(@"loadSuccess=%d",loadSuccess);
//	BOOL loaded = [dylibBundle isLoaded];
//	NSLog(@"loaded = %d",loaded);
	
}

- (void)readCacheFiles {
	NSString *cachePath = [self getCacheFilePath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *subPaths = [fileManager subpathsAtPath:cachePath];
	
	NSLog(@"framework的子路径Arr=%@",subPaths);
}
/// 删除文件
- (void)deleteFile {
	NSString *cachePath = [self getCacheFilePath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	[fileManager removeItemAtPath:cachePath error:&error];
	if (error != nil) {
		NSLog(@"删除文件的error = %@",error);
	}
}

- (void)startDownloadFile {
	AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
	// 创建请求对象
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.25.107:8989/PayFix.zip"]];
	
	NSURLSessionDownloadTask *downloadTask =
	[manage downloadTaskWithRequest:request
						   progress:^(NSProgress * _Nonnull downloadProgress) {
							   NSLog(@"文件大小=%ld 下载进度= %.2f",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount *1.0/downloadProgress.totalUnitCount);
							   
						   }
	 
						destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
							NSString *cachePath = [self getCacheFilePath];
							//拼接文件全路径
//							NSString *fullpath = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
							NSString *fullpath = [cachePath stringByAppendingPathComponent:@"PayFix.zip"];
							NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
							return filePathUrl;
						}
				  completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
					  
					  NSLog(@"文件下载完成路径=%@",filePath.path);
					  // 下载完成就解压文件
					  if (error == nil) {
						  NSString *destinPath = filePath.path.stringByDeletingLastPathComponent;
						  [self unzipFileAtPath:filePath.path toDestination:destinPath];
					  } else {
						  NSLog(@"error = %@",error);
					  }
				  }];
	// 启动任务
	[downloadTask resume];
}

/// 开始下载JS文件
- (void)startDownloadJSFile {
	AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
	// 创建请求对象
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.25.107:8989/Demojs.zip"]];
	
	NSURLSessionDownloadTask *downloadTask =
	[manage downloadTaskWithRequest:request
						   progress:^(NSProgress * _Nonnull downloadProgress) {
							   NSLog(@"js文件大小=%lld 下载进度= %.2f",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount *1.0/downloadProgress.totalUnitCount);
							   
						   }
	 
						destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
							NSString *cachePath = [self getCacheFilePath];
							//拼接文件全路径
							//							NSString *fullpath = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
							NSString *fullpath = [cachePath stringByAppendingPathComponent:@"Demojs.zip"];
							NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
							return filePathUrl;
						}
				  completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
					  
					  NSLog(@"文件下载完成路径=%@",filePath.path);
					  // 下载完成就解压文件
					  if (error == nil) {
						  NSString *destinPath = filePath.path.stringByDeletingLastPathComponent;
						  [self unzipFileAtPath:filePath.path toDestination:destinPath];
					  } else {
						  NSLog(@"error = %@",error);
					  }
				  }];
	// 启动任务
	[downloadTask resume];
}

/// 开始加载从服务端下载的js文件
- (void)startLoadCacheJSFile {
	[JPEngine startEngine];
	NSString *jsFilePath = [[self getCacheFilePath] stringByAppendingPathComponent:@"Demojs.js"];
//	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"unDemo" ofType:@"js"];
	NSString *script = [NSString stringWithContentsOfFile:jsFilePath encoding:NSUTF8StringEncoding error:nil];
	if (script != nil) {
		[JPEngine evaluateScript:script];
	} else {
		NSLog(@"读取js文件失败");
	}
	
}

/// 解压文件
- (void)unzipFileAtPath:(NSString *)currenPath toDestination:(NSString *)unzipPath {
	
	[SSZipArchive unzipFileAtPath:currenPath toDestination:unzipPath delegate:self];
	
}


/// 获取沙盒文件夹路径
- (NSString *)getCacheFilePath {
	NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
	// 拼接文件路径
	NSString *dirPath = [cachePath stringByAppendingPathComponent:@"framework"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	BOOL isDirectory;
	BOOL exit = [fileManager fileExistsAtPath:dirPath isDirectory:&isDirectory];
	
	if (exit == NO) {
		[fileManager createDirectoryAtPath:dirPath
			   withIntermediateDirectories:YES
								attributes:nil
									 error:nil];
	}
	
	return dirPath;
}
/// 开始执行动态库的方法
- (void)startActDylibMethod {
	Class targetClass = NSClassFromString(@"PayFix");
	id obj = [[targetClass alloc] init];
	// 根据字符串查找方法
	[obj performSelector:NSSelectorFromString(@"startShowAlerView")];
}

#pragma mark - <SSZipArchiveDelegate>

- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path
								 zipInfo:(unz_global_info)zipInfo {
	NSLog(@"zip func=%s",__func__);
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path
								zipInfo:(unz_global_info)zipInfo
						   unzippedPath:(NSString *)unzippedPath {
	NSLog(@"zip func=%s",__func__);
	// 解压完成之后删除原.zip文件
	[[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
	}
	return _tableView;
}

@end
