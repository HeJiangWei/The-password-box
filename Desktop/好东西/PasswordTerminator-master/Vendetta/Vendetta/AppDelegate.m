//
//  AppDelegate.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/11.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "AppDelegate.h"
#import "UIKit+Helper.h"
#import "UIImage+ImageEffects.h"
#import "Pagejw0918ControlView.h"
//#import "JW0905KDManager.h"
#import "TabViewController.h"

//// iOS10注册APNs所需头文件
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif


#define BlurViewTag 1001
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    [JW0905KDManager JW0905setupWithBmobAppID:@"5bc4644a81e2c85c21754bf8d1c477f6"
//                               cloudClassName:@"TestObject"
//                                cloudObjectID:@"3gBF555N"
//                                   changeDate:@"17-09-2018-000000"
//                                         JGID:@"1155cf600f0e07764c3428b0"
//                                launchOptions:launchOptions completion:^(BOOL inReview) {
//                                    if (inReview) {
                                        UIStoryboard*storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
                                        TabViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
//                                        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:receive];
//                                        nvc.navigationBar.barTintColor = [UIColor colorWithRed:128/255.0 green:201/255.0 blue:250/250.0 alpha:1];
                                        self.window.rootViewController = receive;
//                                    }
//                                }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//
//    UIImageView *view = [[UIImageView alloc]initWithFrame:keyWindow.bounds];
//    view.tag = BlurViewTag;
//    view.image = [[self convertViewToImage:[[UIKitHelper sharedInstance] getCurrentVC].view] applyBlurWithRadius:15.0f tintColor:[UIColor colorWithWhite:0.7f alpha:0.4f] saturationDeltaFactor:5.0f maskImage:nil];
//    view.alpha = 0.0f;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        [keyWindow addSubview:view];
//        [keyWindow bringSubviewToFront:view];
//        view.alpha = 1.0f;
//    }];
    


    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (UIImage *)convertViewToImage:(UIView *)view
{
    CGSize s = view.bounds.size;
    //下面方法，第一个参数表示区域大小。
    //第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
    //第三个参数就是屏幕密度。
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [keyWindow viewWithTag:BlurViewTag];
    if(view)
    {
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

    
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [JW0905KDManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [JW0905KDManager application:application didReceiveRemoteNotification:userInfo];
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    [JW0905KDManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
//}
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [JW0905KDManager application:application didFailToRegisterForRemoteNotificationsWithError:error];
//}

    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
