//
//  HTProgressHUD.m
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTProgressHUD.h"
#import <MBProgressHUD.h>

@interface HTProgressHUD()

@end

@implementation HTProgressHUD

+(void)showMessage:(NSString *)message forView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = message;
    hub.label.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
    hub.mode = MBProgressHUDModeText;
    hub.margin = 15;
    [hub hideAnimated:YES afterDelay:1.f];
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message andDetailMessage:(NSString *)detailMessage forView:(UIView *)view clickedCancel:(void (^)(void))cancel
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = message;
    if (detailMessage) {
        hub.detailsLabel.text = detailMessage;
    }
    hub.removeFromSuperViewOnHide = YES;
    hub.label.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
    hub.margin = 15;
    hub.mode = MBProgressHUDModeCustomView;
    
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i<16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"voice_search_load_anim_%ld",i]];
        [images addObject:image];
    }
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setAnimationImages:images];
    imageView.animationDuration = 16*0.05;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    hub.customView = imageView;
    
    __weak typeof(hub) __hub = hub;
    __weak typeof(self) __self = self;
    if (cancel) {
        [__hub.bezelView addClickBlock:^(id obj) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消加载数据?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action_0 = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                cancel();
                [__hub hideAnimated:YES];
            }];
            UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"不是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action_0];
            [alert addAction:action_1];
            [[__self getCurrentVC] presentViewController:alert animated:YES completion:nil];
        }];
    }
    hub.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hub.bezelView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.8];
    hub.contentColor = [UIColor whiteColor];
    return hub;
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message andDetailMessage:(NSString *)detailMessage forView:(UIView *)view
{
    return [self LoadingShowMessage:message andDetailMessage:detailMessage forView:view clickedCancel:nil];
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message forView:(UIView *)view
{
    return [self LoadingShowMessage:message andDetailMessage:nil forView:view clickedCancel:nil];
}

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message
{
    return [self LoadingShowMessage:message forView:nil];
}

+(void)HiddenForView:(UIView *)view
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)Hidden
{
    [self HiddenForView:nil];
}





+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}



@end
