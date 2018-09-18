//
//  HTAcountDetailCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/24.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountDetailCell.h"

@implementation HTAcountDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
    self.detailTitleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
    [self ht_bottomLineShow];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
