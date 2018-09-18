//
//  TabViewController.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/12.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "TabViewController.h"
#import "GlobalHeader.h"
#import "Pagejw0918ControlView.h"


@interface TabViewController ()

@property(strong , nonatomic)Pagejw0918ControlView *jw0711pageControlV;
@property(strong , nonatomic)NSArray *jw0711imageArr;
@property(strong , nonatomic)UIImageView *jw0711backImageView;

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 1;
    self.delegate=self;
    UITabBarItem *fuck=[self.tabBar.items objectAtIndex:0];
    UIImage *img1=[UIImage imageNamed:@"first"];
    UIImage *img1_selected=[UIImage imageNamed:@"firstSelected"];
    img1=[img1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    img1_selected=[img1_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fuck.image=img1;
    fuck.selectedImage=img1_selected;
    
    UITabBarItem *fuck1=[self.tabBar.items objectAtIndex:1];
    UIImage *img=[UIImage imageNamed:@"second"];
    UIImage *img_selected=[UIImage imageNamed:@"secondSelected"];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    img_selected=[img_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    fuck1.image=img;
    fuck1.selectedImage=img_selected;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName : GlobalGray} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName : GlobalGray} forState:UIControlStateSelected];
    
    
    NSUserDefaults *UDfaults = [NSUserDefaults standardUserDefaults];
    if (![UDfaults objectForKey:@"1111111"]) {
        [self.view addSubview:self.jw0711pageControlV];
        [UDfaults setObject:@"1111111" forKey:@"1111111"];
    }

    // Do any additional setup after loading the view.
}


-(UIImageView *)jw0711backImageView
{
    if (!_jw0711backImageView) {
        _jw0711backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _jw0711backImageView.alpha = 0.3;
        _jw0711backImageView.image = [UIImage imageNamed:@"444"];
    }
    return _jw0711backImageView;
}


- (NSArray *)jw0711imageArr
{
    if (!_jw0711imageArr) {
        _jw0711imageArr = [NSArray arrayWithObjects:@"1",@"2",nil];
    }
    return _jw0711imageArr;
}

- (Pagejw0918ControlView *)jw0711pageControlV
{
    if (!_jw0711pageControlV) {
        _jw0711pageControlV = [[Pagejw0918ControlView instance] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) andImageList:self.jw0711imageArr];
    }
    return _jw0711pageControlV;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
