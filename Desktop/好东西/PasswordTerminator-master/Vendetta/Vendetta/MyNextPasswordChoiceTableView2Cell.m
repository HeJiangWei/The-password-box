//
//  MyNextPasswordChoiceTableView2Cell.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/19.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "MyNextPasswordChoiceTableView2Cell.h"
#import "UIView2Ext.h"

@implementation MyNextPasswordChoiceTableView2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.customSeperatorView = [[UIView alloc]initWithFrame:CGRectZero];
        _customSeperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_customSeperatorView];
        
        self.customChoiceTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _customChoiceTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _customChoiceTitleLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_customChoiceTitleLabel];
        
        self.selectedIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _selectedIconImageView.image = [UIImage imageNamed:@"choiceSelected"];
        _selectedIconImageView.hidden = YES;
        [self.contentView addSubview:_selectedIconImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _customSeperatorView.frame = CGRectMake(0.0f, self.height - 1.0f, ScreenWidth, 1.0f);
    _customChoiceTitleLabel.frame = CGRectMake(15.0f, (self.height - 15.0f)/2.0f, ScreenWidth - 100.0f, 17.0f);
    _selectedIconImageView.frame = CGRectMake(self.width - 50.0f, (self.height - 31.0f)/2.0f, 35.0f, 31.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
