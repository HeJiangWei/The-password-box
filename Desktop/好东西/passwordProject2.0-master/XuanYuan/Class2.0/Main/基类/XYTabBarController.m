//
//  XYTabBarController.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYTabBarController.h"
#import "HTInputPasswordViewController.h"

/*
 UIApplicationDidEnterBackgroundNotification                 应用程序进入后台
 UIApplicationWillEnterForegroundNotification                应用程序将要进入前台
 UIApplicationDidFinishLaunchingNotification                 应用程序完成启动
 UIApplicationDidFinishLaunchingNotification                 应用程序由挂起变的活跃
 UIApplicationWillResignActiveNotification                   应用程序挂起(有电话进来或者锁屏)
 UIApplicationDidReceiveMemoryWarningNotification            应用程序收到内存警告
 UIApplicationDidReceiveMemoryWarningNotification            应用程序终止(后台杀死、手机关机等)
 UIApplicationSignificantTimeChangeNotification              当有重大时间改变(凌晨0点，设备时间被修改，时区改变等)
 UIApplicationWillChangeStatusBarOrientationNotification     设备方向将要改变
 UIApplicationDidChangeStatusBarOrientationNotification      设备方向改变
 UIApplicationWillChangeStatusBarFrameNotification           设备状态栏frame将要改变
 UIApplicationDidChangeStatusBarFrameNotification            设备状态栏frame改变
 UIApplicationBackgroundRefreshStatusDidChangeNotification   应用程序在后台下载内容的状态发生变化
 UIApplicationProtectedDataWillBecomeUnavailable             本地受保护的文件被锁定,无法访问
 UIApplicationProtectedDataWillBecomeUnavailable             本地受保护的文件可用了
 */

@interface XYTabBarController ()

@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(TabBarTint);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidFinishLaunchingWithNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    
}


//完成启动
- (void)applicationDidFinishLaunchingWithNotification:(NSNotification *)noti
{
    if ([[HTConfigManager sharedconfigManager]isOpenStartPassword])
    {
        HTInputPasswordViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTInputPasswordViewController");
        [self presentViewController:vc animated:YES completion:nil];
    }
}

//进入后台
- (void)applicationDidEnterBackground:(NSNotification *)noti
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        if ([[HTConfigManager sharedconfigManager]isOpenStartPassword])
        {
            HTInputPasswordViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTInputPasswordViewController");
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
