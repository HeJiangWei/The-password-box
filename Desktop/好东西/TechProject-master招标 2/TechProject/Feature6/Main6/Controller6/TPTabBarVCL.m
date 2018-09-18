//
//  TPTabBarVCL.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPTabBarVCL.h"
#import "TPTabBarAnimator.h"
#import "TPSnow5View.h"
#import <YYCategories.h>
#import "TPCommon6Define.h"
@interface TPTabBarVCL()<UITabBarDelegate>
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) TPTabBarAnimator *tabbarAnimator;
@property (nonatomic, strong) TPSnow5View *snow;
@end

@implementation TPTabBarVCL

- (void)viewDidLoad{
    [super viewDidLoad];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"3BB3F7"]} forState:UIControlStateSelected];
}

-(void)viewDidAppear:(BOOL) animated{
    [super viewDidAppear:animated];
    [self.view becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL) animated{
    [super viewDidDisappear:animated];
    [self.view resignFirstResponder];
}

#pragma mark 运动开始
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion==UIEventSubtypeMotionShake) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [TPSnow5View show];
        });
    }
}

- (void)animationWithIndex:(NSInteger)index{
    self.curIndex = index;
    NSMutableArray *arr = [NSMutableArray array];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            UIImageView *image = [view valueForKey:@"info"];
            [arr addObject:image];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.fromValue = [NSNumber numberWithFloat:0.8];
    pulse.toValue= [NSNumber numberWithFloat:1.0];
    [[arr[index] layer] addAnimation:pulse forKey:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.curIndex != index) {
//        [self animationWithIndex:index];
    }
}


@end
