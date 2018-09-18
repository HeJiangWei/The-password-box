//
//  AboutUs1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/1/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AboutUs1ViewController.h"

@interface AboutUs1ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@end

@implementation AboutUs1ViewController

-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    self.bottomConstraint.constant = self.view.safeAreaInsets.bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
     [self rightButtonImage:nil RightButtonTitle:@"关闭" rightButtonTarget:self rightButtonAction:@selector(backTohome)];
    
}

/*
 *  关闭
 */
-(void)backTohome{
//    //  [MobClick event:@"output_close"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
