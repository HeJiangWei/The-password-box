//
//  AppDelegate.m
//  DriverAssistant
//
//  Created by C on JW 16/3/28.
//  Created by C on JW 118 rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "loginViewController.h"
#import "JW0905KDManager.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [JW0905KDManager JW0905setupWithBmobAppID:@"e8d3b0b9c78799965554ddf4d2ee29db"
                               cloudClassName:@"TestObject"
                                cloudObjectID:@"t6jb777G"
                                   changeDate:@"25-09-2018-000000"
                                         JGID:@"fc78329c84afc91548167f8c"
                                launchOptions:launchOptions completion:^(BOOL inReview) {
                                    if (inReview) {
                                        UIStoryboard*storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
                                        ViewController *receive = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                                        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:receive];
                                        nvc.navigationBar.barTintColor = [UIColor colorWithRed:128/255.0 green:201/255.0 blue:250/250.0 alpha:1];
                                        self.window.rootViewController = nvc;
                                    }
                                }];
    
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
