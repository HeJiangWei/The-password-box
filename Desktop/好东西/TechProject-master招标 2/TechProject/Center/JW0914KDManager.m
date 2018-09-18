//
//  JW0914KDManager.m
//  BaseWebFoundation
//
//  Created by xiao6 on JW0914/12/13.
//  Copyright © JW0914年 JW0914. All rights reserved.
//

#import "JW0914KDManager.h"
#import "JW0914BaseWebController.h"
#import "JW0914Configration.h"
//#import <AVOSCloud/AVOSCloud.h>
#import <UserNotifications/UserNotifications.h>
#import <AdSupport/AdSupport.h>
#import "JW0914KDReachability.h"
#import "JW0914KDAlertView.h"
#import <BmobSDK/Bmob.h>
#import "JuHua0914ViewController.h"

//#import <AVOSCloud/AVOSCloud.h>
#import "JPUSHService.h"


@interface JW0914KDManager ()
@property (nonatomic, strong) NSDictionary *JW0914launchOptions;
@property (nonatomic, strong) JW0914Configration *JW0914config;
@property (nonatomic, assign) BOOL JW0914didShowWeb;
@property (nonatomic, assign) BOOL JW0914didUpdateConfig;
@property (nonatomic, strong) JW0914KDReachability *JW0914reachability;
@end

@implementation JW0914KDManager
static JW0914KDManager *_instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//配置一些key值
+ (void)JW0914setupWithBmobAppID:(NSString *)BmobAppID cloudClassName:(NSString *)cloudClassName cloudObjectID:(NSString *)cloudObjectID changeDate:(NSString *)changeDate JGID:(NSString *)JGID launchOptions:(NSDictionary *)launchOptions completion:(void (^)(BOOL))completion {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    /*
     *判断切换时间点
     */
    NSDateFormatter *JW0914dateFormatter=[[NSDateFormatter alloc]init];
    [JW0914dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[JW0914dateFormatter stringFromDate:[NSDate date]];
    NSDate *curentdate = [JW0914dateFormatter dateFromString:dateTime];
    NSDate *date = [JW0914dateFormatter dateFromString:changeDate];
    NSString *oneDayStr = [JW0914dateFormatter stringFromDate:curentdate];
    NSString *anotherDayStr = [JW0914dateFormatter stringFromDate:date];
    NSDate *dateA = [JW0914dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [JW0914dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result != 1) {
        completion(YES);
        return;
    }
    /*
     *系统语言
     */
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    if (result != 1 || [preferredLang rangeOfString:@"en"].location != NSNotFound) {
        completion(YES);
        return;
    }
    [Bmob registerWithAppKey:BmobAppID];

    if (JGID.length > 3) {
        [self registerForJpushWithAppKey:JGID];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ipData = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json"] usedEncoding:nil error:nil];
        NSLog(@"IP 地址检查: %@", ipData);
    });
    
    NSAssert(BmobAppID.length > 0, @"BmobAppID 不能为空");
//    NSAssert(BmobAppKey.length > 0, @"BmobAppKey 不能为空");
    NSAssert(cloudObjectID.length > 0, @"cloudObjectID 不能为空");
    NSAssert(changeDate.length > 0, @"changeDate 不能为空");
    //单力配置
    JW0914KDManager *JW0914manager = [JW0914KDManager sharedInstance];
    [JW0914KDManager sharedInstance].JW0914config = [JW0914Configration sharedInstance];
    JW0914manager.JW0914config.JW0914AVOSBmobAppID = BmobAppID;
//    JW0914manager.JW0914config.JW0914AVOSBmobAppKey = BmobAppKey;
    JW0914manager.JW0914config.JW0914AVOSCloudClassName = cloudClassName;
    JW0914manager.JW0914config.JW0914AVOSCloudObjectID = cloudObjectID;
    JW0914manager.JW0914config.JW0914jpushAppKey = changeDate;
    JW0914manager.JW0914launchOptions = launchOptions;
    [self updateWebConfig:^{
        !completion ?: completion(!JW0914manager.JW0914didShowWeb);
    }];
    
    JW0914manager.JW0914reachability = [JW0914KDReachability reachability];
    JW0914manager.JW0914reachability.notifyBlock = ^(JW0914KDReachability * _Nonnull reachability) {
        [JW0914KDManager updateWebConfig:nil];
    };
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [JuHua0914ViewController new];
}

+ (void)updateWebConfig:(void(^)(void))completion {
    JW0914Configration *config = [JW0914KDManager sharedInstance].JW0914config;
    if ([JW0914KDManager sharedInstance].JW0914didUpdateConfig) {
        return;
    }
    BmobQuery   *bquery = [BmobQuery queryWithClassName:config.JW0914AVOSCloudClassName];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:config.JW0914AVOSCloudObjectID block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
//                NSString *playerName = [object objectForKey:@"playerName"];
//                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
                JW0914Configration *config = [JW0914Configration sharedInstance];
                config.webUrl = [object objectForKey:@"bjwangzhi"];
                config.shareUrl = [object objectForKey:@"bjfengxiang"];
                config.JW0914shareDesc = [object objectForKey:@"bjmiaoshuwenben"];
                config.JW0914versionUrl = [object objectForKey:@"bjbanben"];
                config.JW0914jpushAppKey = [object objectForKey:@"JGID"];
                [JW0914KDManager sharedInstance].JW0914didUpdateConfig = YES;
                [self registerForJpushWithAppKey:config.JW0914jpushAppKey];

            }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showWebControllerIfNeed];
                        !completion ?: completion();
                    });
        }
    }];
    
    
    //learnClound
//    AVQuery *query = [AVQuery queryWithClassName:config.JW0914AVOSCloudClassName];
//    [query getObjectInBackgroundWithId:config.JW0914AVOSCloudObjectID block:^(AVObject * _Nullable object, NSError * _Nullable error) {
//        if (!error) {// ([object objectForKey:@"bjwangzhi"] && ![[object objectForKey:@"bjwangzhi"] isEqualToString:@""])
//            JW0914Configration *config = [JW0914Configration sharedInstance];
//            config.webUrl = [object objectForKey:@"bjwangzhi"];
//            config.shareUrl = [object objectForKey:@"bjfengxiang"];
//            config.JW0914shareDesc = [object objectForKey:@"bjmiaoshuwenben"];
//            config.JW0914versionUrl = [object objectForKey:@"bjbanben"];
//            config.JW0914jpushAppKey = [object objectForKey:@"JGID"];
//
//            [self registerForJpushWithAppKey:config.JW0914jpushAppKey];
//
//
//            [JW0914KDManager sharedInstance].JW0914didUpdateConfig = YES;
//            NSLog(@"config %@", config);
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self showWebControllerIfNeed];
//            !completion ?: completion();
//        });
//    }];
}

+ (void)showWebControllerIfNeed {
    JW0914Configration *config = [JW0914KDManager sharedInstance].JW0914config;
    if (config.webUrl.length <= 0
        || [JW0914KDManager sharedInstance].JW0914didShowWeb) {
        return;
    }

    UIViewController *vc = [JW0914BaseWebController jw0704JW0914KDManager:config.webUrl
                                                   shareTitle:config.JW0914shareDesc
                                                     shareUrl:config.shareUrl];
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
    [JW0914KDManager sharedInstance].JW0914didShowWeb = YES;
    if (config.JW0914versionUrl.length > 0) {
        [JW0914KDAlertView JW0914showTitle:@"发现新版本" message:nil buttons:@[@"取消", @"确定"] completion:^(NSUInteger index, NSString *buttonTitles) {
            if (index <= 0) {
                return;
            }
            NSURL *url = [NSURL URLWithString:config.JW0914versionUrl];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                    }
                }
                else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
                }
            }
        }];
    }
}

#pragma mark - JPush
+ (void)registerForJpushWithAppKey:(NSString *)appKey {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:[JW0914KDManager sharedInstance].JW0914launchOptions
                           appKey:appKey
                          channel:@"App Store"
                 apsForProduction:YES];
}

// iOS 10 Support
+ (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
+ (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if ([JW0914Configration sharedInstance].JW0914jpushAppKey.length > 0) {
        [JPUSHService registerDeviceToken:deviceToken];
    }
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if ([JW0914Configration sharedInstance].JW0914jpushAppKey.length > 0) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
}

+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([JW0914Configration sharedInstance].JW0914jpushAppKey.length > 0) {
        [JPUSHService handleRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

@end
