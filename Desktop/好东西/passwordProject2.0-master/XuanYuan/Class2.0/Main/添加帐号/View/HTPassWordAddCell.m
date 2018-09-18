//
//  HTPassWordAddCell.m
//  XuanYuan
//
//  Created by niesiyang on 2018/1/22.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTPassWordAddCell.h"

@interface HTPassWordAddCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordBgView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
//@property (nonatomic,assign) BOOL isShowPassword;
@end

@implementation HTPassWordAddCell
- (IBAction)clickedLeft:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"正在开发中..." message:@"尽请期待❤️" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [[HTTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
}
- (IBAction)clickedRight:(UIButton *)sender {
    [self configState:![self isShowPassWord]];
}

-(void)configText:(NSString *)text
{
    self.inputPasswordTextField.text = nil;

    if (![HTTools ht_isBlankString:text]) {
        self.inputPasswordTextField.text = text;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self ht_bottomLineShow];
    [self.passwordBgView ht_bottomLineShow];
    [self.passwordBgView ht_bottomLineLeftAndRightMargins:HTMarginsMake(16, 0)];

    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) __self = self;
    self.inputPasswordTextField.delegate = self;
    [self.inputPasswordTextField ht_editingChanged:^{
        if (__self.inputPasswordTextField.markedTextRange == nil) {
            if (__self.textChange) {
                __self.textChange(__self.inputPasswordTextField.text);
            }
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([HTTools ht_IsChinese:string]) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.inputPasswordTextField) {
        [self configState:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.inputPasswordTextField) {
        if (textField.isFirstResponder) {
            [self configState:YES];
        }
    }
    return YES;
}

-(BOOL)isShowPassWord
{
    return self.inputPasswordTextField.isSecureTextEntry;
}

-(void)configState:(BOOL)state
{
    if (state)
    {
        self.inputPasswordTextField.secureTextEntry = YES;
        [self.rightBtn setTitle:@"显示密码" forState:UIControlStateNormal];
    }
    else
    {
        self.inputPasswordTextField.secureTextEntry = NO;
        [self.rightBtn setTitle:@"隐藏密码" forState:UIControlStateNormal];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
