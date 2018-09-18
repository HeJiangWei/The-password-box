//
//  XYSettingCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/30.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYSettingCell.h"

@interface XYSettingCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@end

@implementation XYSettingCell

-(void)configTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(void)configSwitch:(BOOL)isOn
{
    self.switchBtn.on = isOn;
}
- (IBAction)changeValue:(UISwitch *)sender {
    if (self.switchChange) {
        self.switchChange(sender.isOn);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self ht_bottomLineShow];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
