//
//  ViewController.m
//  自定义登录界面
//
//  Created by apple1 on 16/8/10.
//  Copyright © 2016年 90909. All rights reserved.
//

#import "LoginViewController.h"
#import "LY6TextField.h"
#import "LYButton.h"
#import "NextViewController.h"

#import "AppDelegate.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    LY6TextField *username;
    LY6TextField *password;
    LYButton *login;
}

@end

@implementation LoginViewController

-(instancetype)init{
    if(self = [super init]){
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer: [self backgroundLayer]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setUp];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
-(void)setUp{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 150);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"计划分析软件";
    titleLabel.font = [UIFont systemFontOfSize:40.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    detail.center = CGPointMake(self.view.center.x,630);
    detail.textColor = [UIColor whiteColor];
    //    detail.text = @"Don`t have an account yet? Sign Up";
    detail.font = [UIFont systemFontOfSize:13.f];
    detail.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detail];
    
    username = [[LY6TextField alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
    username.center = CGPointMake(self.view.center.x, self.view.center.y);
    username.ly_placeholder = @"Username";
    username.tag = 0;
    username.textField.delegate = self;
    [self.view addSubview:username];
    
    password = [[LY6TextField alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
    password.center = CGPointMake(self.view.center.x, username.center.y+60);
    password.ly_placeholder = @"Password";
    password.textField.delegate = self;
    password.tag = 1;
    [self.view addSubview:password];
    
    login = [[LYButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    login.superVC = self;
    login.userInteractionEnabled = NO;
    login.alpha = 0.5;
    login.center = CGPointMake(self.view.center.x, password.center.y+100);
    
    [self.view addSubview:login];
    
    
    __block LYButton *button = login;
    
    login.translateBlock = ^{
        NSLog(@"跳转了哦");
        button.bounds = CGRectMake(0, 0, 44, 44);
        button.layer.cornerRadius = 22;
        
        
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        SelfDetailViewController *selfdetailVC = [mainSB instantiateViewControllerWithIdentifier:@"ChangeSecondPWViewController"];
        //        [self.navigationController pushViewController:selfdetailVC animated:YES];
        UINavigationController *nvc = [mainSB instantiateViewControllerWithIdentifier:@"55555555"];
        
        //        55555555
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = nvc;
        
        //        [self presentViewController:nvc animated:YES completion:nil];
        
        
        
        //        NextViewController *nextVC = [[NextViewController alloc]init];
        //        [self presentViewController:nextVC animated:YES completion:nil];
    };
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (password.textField.text.length > 4 && username.textField.text.length > 4) {
        login.userInteractionEnabled = YES;
        login.alpha = 1;
    }else{
        login.userInteractionEnabled = NO;
        login.alpha = 0.5;
    }
    return YES;
}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:92/255.0 green:191/255.0 blue:247/255.0 alpha:1].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
}

@end
