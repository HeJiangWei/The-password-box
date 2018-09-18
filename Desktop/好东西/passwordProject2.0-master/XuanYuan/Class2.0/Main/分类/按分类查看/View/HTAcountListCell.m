//
//  HTAcountListCell.m
//  XuanYuan
//
//  Created by niesiyang on 2018/1/23.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountListCell.h"

@implementation HTAcountListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self ht_bottomLineShow];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.acountTitleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
    self.acountLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);

    // Configure the view for the selected state
}

@end
