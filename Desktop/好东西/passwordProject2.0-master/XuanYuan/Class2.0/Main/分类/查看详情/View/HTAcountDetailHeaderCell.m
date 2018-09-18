//
//  HTAcountDetailHeaderCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/24.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountDetailHeaderCell.h"

@implementation HTAcountDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self ht_bottomLineShow];
    [self.iconImageView ht_setBorderWidth:0.5 Color:RGBHex(0xe1e1e1)];
    self.acountTitleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
    self.acountKindLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_2);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
