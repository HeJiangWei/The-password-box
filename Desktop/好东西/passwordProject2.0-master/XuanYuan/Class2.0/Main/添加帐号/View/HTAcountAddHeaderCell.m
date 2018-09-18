//
//  HTAcountAddHeaderCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddHeaderCell.h"

@interface HTAcountAddHeaderCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation HTAcountAddHeaderCell

-(void)configText:(NSString *)text
{
    self.inputTextField.text = nil;
    if (![HTTools ht_isBlankString:text]) {
        self.inputTextField.text = text;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.inputBgView ht_bottomLineShow];
    [self.iconImage ht_setBorderWidth:0.5 Color:RGBHex(0xe1e1e1)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputTextField.delegate = self;
    __weak typeof(self) __self = self;
    [self.inputTextField ht_editingChanged:^{
        if (__self.inputTextField.markedTextRange == nil) {
            if (__self.textChange) {
                __self.textChange(__self.inputTextField.text);
            }
        }
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
