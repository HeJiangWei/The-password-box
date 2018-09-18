//
//  HTAcountAddCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddCell.h"

@interface HTAcountAddCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputAcountLabel;

@end

@implementation HTAcountAddCell

-(void)configText:(NSString *)text
{
    self.inputAcountLabel.text = nil;
    if (![HTTools ht_isBlankString:text]) {
        self.inputAcountLabel.text = text;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.inputAcountLabel.delegate = self;
    [self ht_bottomLineShow];
    [self ht_bottomLineLeftAndRightMargins:HTMarginsMake(16, 0)];
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) __self = self;    
    [self.inputAcountLabel ht_editingChanged:^{
        if (__self.inputAcountLabel.markedTextRange == nil) {
            if (__self.textChange) {
                __self.textChange(__self.inputAcountLabel.text);
            }
        }
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
