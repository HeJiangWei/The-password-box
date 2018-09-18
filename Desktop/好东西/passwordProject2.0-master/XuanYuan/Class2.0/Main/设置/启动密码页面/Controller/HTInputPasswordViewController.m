//
//  HTInputPasswordViewController.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/31.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTInputPasswordViewController.h"

@interface HTInputPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@end

@implementation HTInputPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTextField.inputView = nil;
    self.inputTextField.returnKeyType = UIReturnKeyDone;
    self.inputTextField.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputTextField becomeFirstResponder];
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self checkPassword];
    return YES;
}
- (IBAction)clicked:(UIButton *)sender {
    [self checkPassword];
}


-(void)checkPassword
{
    [self.view endEditing:YES];
    if (self.inputTextField.text.length<1) {
        return;
    }
    if ([[HTConfigManager sharedconfigManager]checkInputPassword:self.inputTextField.text])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [HTProgressHUD showMessage:@"密码错误" forView:self.view];
    }
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
