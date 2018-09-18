//
//  AppDelegate.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"

#define UMAppKeyIdRelease @"5a61afe58f4a9d5ba300006a"  //正式
#define UMAppKeyIdDeBug @"5a4b2c6ff43e484e52000021"   //测试
#define UMAppKeyIdMySelf @"587356669f06fd407a00126e"   //自己的
#import "MainViewController.h"

#import "JW0905KDManager.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    UMConfigInstance.appKey = UMAppKeyIdRelease;//自己的  587356669f06fd407a00126e    //公司测试的 5a4b2c6ff43e484e52000021  //正式 5a61afe58f4a9d5ba300006a
//    UMConfigInstance.channelId = @"App Store";
//
//    [MobClick setCrashReportEnabled:YES];
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
////    [[UMSocialManager defaultManager]openLog:YES];
//
//    [[UMSocialManager defaultManager]setUmSocialAppkey:UMAppKeyIdRelease];
//    [self configUSharePlatforms];
//
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
//    [NSThread sleepForTimeInterval:2];
    
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [JW0905KDManager JW0905setupWithBmobAppID:@"c6c0b2177aa0855d27214af7ab334906"
                               cloudClassName:@"TestObject"
                                cloudObjectID:@"Z4NL222V"
                                   changeDate:@"18-09-2018-000000"
                                         JGID:@"13217a682251bc2bc597bcb2"
                                launchOptions:launchOptions completion:^(BOOL inReview) {
                                    if (inReview) {
                                        UIStoryboard*storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
                                        
                                        MainViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                                        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:receive];

                                        self.window.rootViewController = nvc;
                                    }
                                }];
    
    
    
    return YES;
    
}

/*
 *  设置分享的品平台
 */
//-(void)configUSharePlatforms{

    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxc166221a65567608" appSecret:@"ce2602a8ea9d50dc0509f72f9f733fa0" redirectURL:nil];
//
//    /* 设置分享到QQ互联的appID
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     100424468.no permission of union id
//     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106553763"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//
//    /*
//     设置新浪的appKey和appSecret
//     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
//     https://api.weibo.com/oauth2/call.html
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"875737685"  appSecret:@"06590c38829aa29550ab352cd4db87f6" redirectURL:@"https://api.weibo.com/oauth2/call.html"];
//
//}
//
////分享回调
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    NSLog(@"这边是回来了吧");
//
//    BOOL result = [[UMSocialManager defaultManager]handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
////    if (result) {
////        //成功了
////        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kShareSuccess];
////        [[NSUserDefaults standardUserDefaults] synchronize];
////
////        [KVNProgress showSuccessWithStatus:@"分享成功"];
////    }
////    else{
////        [KVNProgress showErrorWithStatus:@"分享失败,请再次分享"];
////
////    }
//    return result;
//}

//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    
////    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    NSLog(@"这边是回来了吧%@",url);
//    
////    if (result) {
////        //成功了
////        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kShareSuccess];
////        [[NSUserDefaults standardUserDefaults] synchronize];
////        [KVNProgress showSuccessWithStatus:@"分享成功"];
////    }
////    else{
////        [KVNProgress showErrorWithStatus:@"分享失败,请再次分享"];
////
////    }
//    return result;
//    
//}

-(void)applicationDidBecomeActive:(UIApplication *)application{
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"WillResignActive");
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"DidEnterBackground");

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    NSLog(@"WillEnterForeground");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JW0905KDManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JW0905KDManager application:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JW0905KDManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [JW0905KDManager application:application didFailToRegisterForRemoteNotificationsWithError:error];
}



@end
