//
//  MainViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "BusinessLicenseViewController.h"
#import "PhotoChoseViewController.h"
#import "FeatureSuggestionsViewController.h"
#import "HelpCenter1ViewController.h"
#import "DoubleImageOfTakePhotoController.h"
//#import <UShareUI/UShareUI.h>
#import "PopShareView.h"
#import "PopClickView.h"
//#import <WXApi.h>
//#import <WeiboSDK.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import "NetWorkRequest.h"
#import "VersionUpDataView.h"
#import "WatermarkContent1ViewController.h"
#import <KVNProgress.h>
#import "AppDelegate.h"
#import "AboutUs1ViewController.h"
#define HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define WIDTH  ([[UIScreen mainScreen] bounds].size.width)

@interface MainViewController ()

@end

@implementation MainViewController

/*
 *  请求新的版本信息
 */
-(void)requestNewVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //设备标识
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [[NetWorkRequest sharedNetWork]GET:kGetVersion delegate:nil parameters:@{@"timestamp":safeString([Tools getNowTimeTimestamp]),@"platform":@"ios",@"channel":@"apple",@"version":safeString(app_Version),@"device":safeString(idfv)}.mutableCopy success:^(id responseObject) {
       
        NSLog(@"新的版本==%@",responseObject);

        if (responseObject&&responseObject[@"data"]) {
            
            NSDictionary *dic = responseObject[@"data"];
            
            NSString * note = dic[@"note"];
            NSLog(@"tishiyu======%@",note);
            NSString *code = dic[@"code"];
            //获取手机程序的版本号
            NSString *ver = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            
            if ([ver compare:code] == NSOrderedAscending) {
                VersionUpDataView *view = [[VersionUpDataView alloc]initWithShowFrame:self.view.bounds andAlpha:0.3];
//                NSString * str = @"升级提示";
                CGSize size = [note boundingRectWithSize:CGSizeMake(view.bounds.size.width-130, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName] context:nil].size;
                
                CGFloat height = size.height+ 15;
                view.updatePromptText.frame = CGRectMake(15, (kScreenWidth - 100)/275 * 385/2 + 38, view.bounds.size.width-130, height);
                
                view.updatePromptText.text = note ;
                
                WeakSelf;
                view.updateAction = ^{
                    
                    [weakSelf updateAction];
                    
                };
                [view show];

            }
            
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"请求错误");
        
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
//    [self requestNewVersion];
//
//    NSString *timeString = [[NSUserDefaults standardUserDefaults] objectForKey:kLaunchTimeShow];
//
//    if (timeString==nil) {
//
//        NSString *timeString = [Tools getNowTimeTimestamp];
//        [[NSUserDefaults standardUserDefaults] setObject:safeString(timeString) forKey:kLaunchTimeShow];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//    }
//    else{
//
//        if ([self isTimeToLimitWeek]) {
//
//            NSString *timeString = [Tools getNowTimeTimestamp];
//            [[NSUserDefaults standardUserDefaults] setObject:safeString(timeString) forKey:kLaunchTimeShow];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [self popshareWithshareTitle:@"觉得好用就分享给朋友们"];
//        }
//
//    }

    
    self.title = @"首页";
    
    [self rightButtonImage:nil RightButtonTitle:@"关于" rightButtonTarget:self rightButtonAction:@selector(shareAction)];
    
}

    
-(void)shareAction{
    
    AboutUs1ViewController * aboutUSView = [[AboutUs1ViewController alloc]init];
    [self.navigationController pushViewController:aboutUSView animated:YES];
    
}


//一张照片的点击事件
- (IBAction)gotoBusinessLicenseVCAction:(UIButton *)sender {
    
    //  [MobClick event:@"single_entry"];//[首页 单面]

//        NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
//        WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];

//        if (model==nil||!model.isSetWaterMark) {
//            if (IOS11_OR_LATER) {
//                [self initOneView:self.view.safeAreaInsets];
//            }
//            else{
//                [self initOneView:UIEdgeInsetsZero];
//            }
//        }else{
    
            BusinessLicenseViewController *vc = [[BusinessLicenseViewController alloc] init];
//            AppDelegate*dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            dele.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
//            [dele.window makeKeyAndVisible];

            [self.navigationController pushViewController:vc animated:true];
//        }
}



//相册选择的点击事件 打开相册
- (IBAction)gotoPhotoChoseVCAction:(UIButton *)sender {
    
    //  [MobClick event:@"album_entry"];//[首页 相册]
    PhotoChoseViewController *vc = [[PhotoChoseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}


/*
 *  弹框分享
 */
-(void)popshareWithshareTitle:(NSString *)shareTitle{
    
    PopClickView *view = [[PopClickView alloc]initWithShowFrame:self.view.bounds andAlpha:0.3];
    view.label.text = shareTitle;
    WeakSelf;
    view.shareAction = ^{
        [weakSelf shareAction];
    };
    [view show];
}



//升级，跳转到App Store
-(void)updateAction{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1328253837"]];
    if (IOS10_OR_LATER) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    else{
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
