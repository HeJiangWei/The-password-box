//
//  HTInfoPassWordAddCell.m
//  XuanYuan
//
//  Created by niesiyang on 2018/1/22.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTInfoPassWordAddCell.h"

@interface HTInfoPassWordAddCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBgVIew;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTitleTextField;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTextField;

@end

@implementation HTInfoPassWordAddCell

-(void)configSubTitle:(NSString *)subTitle andPassword:(NSString *)password
{
    self.inputTitleTextField.text = nil;
    self.inputPasswordTextField.text = nil;

    if (![HTTools ht_isBlankString:subTitle]) {
        self.inputTitleTextField.text = subTitle;
    }
    
    if (![HTTools ht_isBlankString:password]) {
        self.inputPasswordTextField.text = password;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self ht_bottomLineShow];
    
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
    self.passwordLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputTitleTextField.delegate = self;
    self.inputPasswordTextField.delegate = self;
    
    __weak typeof(self) __self = self;
    [self.inputTitleTextField ht_editingChanged:^{
        if (__self.inputTitleTextField.markedTextRange == nil) {
            if (__self.textChange) {
                __self.textChange(__self.inputTitleTextField.text,__self.inputPasswordTextField.text);
            }
        }
    }];
    
    [self.inputPasswordTextField ht_editingChanged:^{
        if (__self.inputPasswordTextField.markedTextRange == nil) {
            if (__self.textChange) {
                __self.textChange(__self.inputTitleTextField.text,__self.inputPasswordTextField.text);
            }
        }
    }];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
