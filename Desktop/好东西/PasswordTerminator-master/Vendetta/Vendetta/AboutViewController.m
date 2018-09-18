//
//  AboutViewController.m
//  Vendetta
//
//  Created byjw Yh c on 15/10/19.
//  Copyright © 2015年 chen Yuheng. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *MainView;
@property (weak, nonatomic) IBOutlet UITextView *ContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *LinkLabel;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BackBtn.layer.cornerRadius = 4.0f;
    self.BackBtn.layer.masksToBounds = YES;
    self.MainView.frame = CGRectMake(0.0f, 0.0f,ScreenWidth , ScreenHeight);
    [self.ContentTextView sizeToFit];
    [self.LinkLabel addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
    self.LinkLabel.titleLabel.numberOfLines = 0;
    [self.LinkLabel.titleLabel sizeToFit];
    // Do any additional setup after loading the view.
}

- (void)jump
{
    NSURL *url= [NSURL URLWithString:@"https://github.com/HeJiangWei/PassWordManager"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
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
