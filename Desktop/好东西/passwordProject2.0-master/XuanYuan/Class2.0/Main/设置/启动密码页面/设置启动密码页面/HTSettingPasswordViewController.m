//
//  HTSettingPasswordViewController.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/31.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTSettingPasswordViewController.h"

@interface HTSettingPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation HTSettingPasswordViewController

- (IBAction)clickedSure:(id)sender {
    [self.view endEditing:YES];
    
    if ([HTTools ht_isBlankString:self.textField.text]) {
        [HTProgressHUD showMessage:@"您还没有输入哦~" forView:self.view];
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"您设置的密码是:(%@)\n请妥善保管\n是否保存?",self.textField.text];
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[HTConfigManager sharedconfigManager]startPassword:self.textField.text];
        [[HTConfigManager sharedconfigManager]isOpenStartPassword:YES];
        [self.navigationController popViewControllerAnimated:YES];
        [HTProgressHUD showMessage:@"设置成功" forView:self.navigationController.view];
    }];
    [vc addAction:action0];
    [vc addAction:action1];
    [self presentViewController:vc animated:YES completion:nil];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置启动密码";
    self.textField.delegate = self;
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(viewBackgroundColor2);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.sureBtn.enabled = NO;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.sureBtn.enabled = YES;
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleDefault;
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
