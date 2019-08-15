require('UIAlertController,UIAlertAction');
defineClass('MyFirstVC', {
			presenAlerView: function() {
			var alerController = UIAlertController.alertControllerWithTitle_message_preferredStyle("测试2", "测试是否被调用2", 0);
			var action1 = UIAlertAction.actionWithTitle_style_handler("确定", 0, block('UIAlertAction*', function(action) {
																					 
																					 }));
			var cancel = UIAlertAction.actionWithTitle_style_handler("取消", 1, block('UIAlertAction*', function(action) {
																					
																					}));
			alerController.addAction(action1);
			alerController.addAction(cancel);
			
			self.presentViewController_animated_completion(alerController, YES, block(function() {
																					  
																					  }));
			},
			});
