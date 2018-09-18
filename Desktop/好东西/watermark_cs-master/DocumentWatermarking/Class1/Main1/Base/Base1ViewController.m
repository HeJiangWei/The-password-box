//
//  Base1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Base1ViewController.h"
#import "UIColor+16.h"
#import "EnlargeButton.h"
//#import <UMMobClick/MobClick.h>
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height
@interface Base1ViewController ()

@end

@implementation Base1ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromClass([self class]));
//    [MobClick beginLogPageView:NSStringFromClass([self class])]; //("Pagename"为页面名称，可自定义)
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@",NSStringFromClass([self class]));
//    [MobClick endLogPageView:NSStringFromClass([self class])]; //("Pagename"为页面名称，可自定义)
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"0473F5"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    
    EnlargeButton * leftButton = [EnlargeButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 10, 70, 50);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"BackButton"] forState:UIControlStateNormal];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    leftButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [leftButton addTarget:self action:@selector(gobackAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.navigationController.childViewControllers.count>1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

//    UIScreenEdgePanGestureRecognizer *pangess = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGess)];
//    pangess.edges = UIRectEdgeLeft;
//    [self.view addGestureRecognizer:pangess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *  返回边缘手势
 */
-(void)handleGess{
    if (self.navigationController.childViewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)rightButtonImage:(UIImage *)image RightButtonTitle:(NSString *)rightBtnTitle rightButtonTarget:(id)target rightButtonAction:(SEL)action{
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KWIDTH - 80, 10, 80, 20);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    [rightButton setTitle:rightBtnTitle forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:rightBtnTitle style:UIBarButtonItemStyleDone target:target action:action];
    
}

// 返回事件
-(void)gobackAction{
    if (_backCall) {
        _backCall();
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
