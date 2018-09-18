//
//  AppDelegate.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/16.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

//ios9之前
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}
//ios9之后
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{

}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    [self configIQKboardManager];
    [self creatDataBaseWithName:@"t_user"];
    return YES;
}

//进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {


}

//进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {

    

}


//取消激活状态
- (void)applicationWillResignActive:(UIApplication *)application {
    

}

//程序被激活
- (void)applicationDidBecomeActive:(UIApplication *)application {
 
    
}

//禁用三方键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return [[HTConfigManager sharedconfigManager] isAllowThirdKeyboard];
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)configIQKboardManager
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; //获取类库的单例变量
    keyboardManager.enable = YES; //控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; //控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; //控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;//有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; //控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; //是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; //设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 60.0f; // 输入框距离键盘的距离
}

- (void)creatDataBaseWithName:(NSString *)databaseName
{
    NSString *path = [HTTools ht_sandbox_getDocuments];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {
        // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
            //暂时无迁移
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

@end
