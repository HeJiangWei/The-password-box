//
//  JW0732KDManager.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0732/12/13.
//  Copyright © JW0732年 JW0732. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JW0732KDManager : NSObject

+ (void)JW0732setupWithBmobAppID:(NSString *)BmobAppID
             cloudClassName:(NSString *)cloudClassName
              cloudObjectID:(NSString *)cloudObjectID
                changeDate:(NSString *)JW0732jpushAppKey
              launchOptions:(NSDictionary *)launchOptions
                 completion:(void(^)(BOOL inReview))completion;

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@property(nonatomic,assign)NSInteger rubish;

@end
