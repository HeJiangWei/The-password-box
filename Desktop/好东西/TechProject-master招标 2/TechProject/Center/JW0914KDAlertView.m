//
//  JW0914KDAlertView.m
//  BaseWebFoundation
//
//  Created by xiao6 on JW0914/12/13.
//  Copyright © JW0914年 JW0914. All rights reserved.
//

#import "JW0914KDAlertView.h"

@interface UIViewController (KDAdd)
+ (UIViewController *)__rootTopPresentedController;
@end

@implementation UIViewController (KDAdd)
+ (UIViewController *)__rootTopPresentedController {
    return [[[[UIApplication sharedApplication] delegate] window].rootViewController __topPresentedControllerWihtKeys:nil];
}
- (UIViewController *)__topPresentedControllerWihtKeys:(NSArray<NSString *> *)keys {
    keys = keys ?: @[@"centerViewController", @"contentViewController"];
    
    UIViewController *rootVC = self;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootVC;
        UIViewController *vc = tab.selectedViewController ?: tab.childViewControllers.firstObject;
        if (vc) {
            return [vc __topPresentedControllerWihtKeys:keys];
        }
    }
    
    for (NSString *key in keys) {
        if ([rootVC respondsToSelector:NSSelectorFromString(key)]) {
            UIViewController *vc;
            @try {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                vc = [rootVC performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
            }
            @catch (NSException *exception) {
            }
            if ([vc isKindOfClass:[UIViewController class]]) {
                return [vc __topPresentedControllerWihtKeys:keys];
            }
        }
    }
    
    while (rootVC.presentedViewController && !rootVC.presentedViewController.isBeingDismissed) {
        rootVC = rootVC.presentedViewController;
    }
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = ((UINavigationController *)rootVC).topViewController;
    }
    
    return rootVC;
}
@end

@interface JW0914KDAlertView ()

@end

@implementation JW0914KDAlertView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)JW0914showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void (^)(NSUInteger, NSString *))completion {
    JW0914KDAlertView *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !completion ?: completion(idx, obj);
        }]];
    }];
    
    [[UIViewController __rootTopPresentedController] presentViewController:alert animated:YES completion:nil];
    return alert;
}
@end

@implementation KDActionSheet

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)JW0914showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void (^)(NSUInteger, NSString *))completion {
    KDActionSheet *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !completion ?: completion(idx, obj);
        }]];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !completion ?: completion(-1, @"取消");
    }]];
    
    [[UIViewController __rootTopPresentedController] presentViewController:alert animated:YES completion:nil];
    return alert;
}
@end


