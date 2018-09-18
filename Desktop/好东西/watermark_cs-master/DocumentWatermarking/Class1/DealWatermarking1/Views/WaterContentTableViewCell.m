//
//  WaterContentTableViewCell.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WaterContentTableViewCell.h"

@implementation WaterContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.titleTextLabel.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
//    self.titleTextLabel.layer.borderWidth = 0.5;
//    self.clickButton.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
//    self.clickButton.layer.borderWidth = 0.5;
//    self.clickButton.userInteractionEnabled = NO;
}

- (IBAction)editAction:(UIButton *)sender {
    if (_editAction) {
        _editAction();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
