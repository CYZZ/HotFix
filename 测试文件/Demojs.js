require('UIAlertController,UIAlertAction,MyPay');
require('JPEngine').addExtensions(['JPBlock']);
defineClass('MyFirstVC', {
            presenAlerView: function() {
            var alerController = UIAlertController.alertControllerWithTitle_message_preferredStyle("测试沙盒", "已经成功的加载沙盒的JS文件0815", 0);
           //`self` is not available here, use `slf` instead.
            var slf = self;
            var action1 = UIAlertAction.actionWithTitle_style_handler("微信", 0, block('void, UIAlertAction*', function(action) {
                                                                                     slf.testLogMessage();
                                                                                     MyPay.weixinpay();
                                                                                     }));
            var action2 = UIAlertAction.actionWithTitle_style_handler("支付宝", 0, block('void, UIAlertAction*', function(action) {
                                                                                     slf.testLogMessage();
                                                                                     var pay = MyPay.alloc().init();
                                                                                     pay.alipay_isShow(["abc"], true);
                                                                                     }));
            var cancel = UIAlertAction.actionWithTitle_style_handler("取消", 1, block('void, UIAlertAction*', function(action) {
                                                                                    slf.cancelClick();
                                                                                    }));
            alerController.addAction(action1);
            alerController.addAction(action2);
            alerController.addAction(cancel);
            
            self.presentViewController_animated_completion(alerController, YES, block('void', function() {
                                                                                      slf.alerComple();
                                                                                      }));
            },
            });
