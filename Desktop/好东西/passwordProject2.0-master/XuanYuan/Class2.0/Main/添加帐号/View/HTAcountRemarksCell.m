//
//  HTAcountRemarksCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/23.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountRemarksCell.h"

@interface HTAcountRemarksCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation HTAcountRemarksCell

-(void)configText:(NSString *)text
{
    self.remarkLabel.text = text;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self ht_bottomLineShow];
    self.titleLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
