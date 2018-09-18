//
//  MyNextPasswordTableView2Cell.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/16.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "MyNextPasswordTableView2Cell.h"
#import "Encryp2tion.h"
#import "Password2Factory.h"

@implementation MyNextPasswordTableView2Cell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.customBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        _customBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_customBackgroundView];
        
        self.refreshButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [_refreshButton addTarget:self action:@selector(customRefresh:) forControlEvents:UIControlEventTouchUpInside];
        [_customBackgroundView addSubview:_refreshButton];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:MyNextPasswordTimeLabelFont];
        _timeLabel.textColor = GlobalGray;
        [_customBackgroundView addSubview:_timeLabel];
        
        self.serialCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _serialCodeLabel.font = [UIFont systemFontOfSize:MyNextPasswordCodeLabelFont];
        _serialCodeLabel.textColor = [UIColor blackColor];
        _serialCodeLabel.textAlignment = NSTextAlignmentCenter;
        [_customBackgroundView addSubview:_serialCodeLabel];
        
        self.codeTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _codeTitleLabel.font = [UIFont systemFontOfSize:MyNextPasswordTitleLabelFont];
        _codeTitleLabel.textColor = [UIColor blackColor];
        [_customBackgroundView addSubview:_codeTitleLabel];
    }
    return self;
}

- (void)customRefresh:(id)sender
{
    if(self.refreshBlock)
    {
        self.refreshBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _customBackgroundView.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, self.height);
    
    CGFloat timeLabelWidth = [UIKitHelper getTextWidthWithText:@"30秒后刷新" andMaxHeight:MyNextPasswordTimeLabelFont andFont:[UIFont systemFontOfSize:MyNextPasswordTimeLabelFont]];
    _timeLabel.frame = CGRectMake((ScreenWidth - timeLabelWidth)/2.0f, 20.0f, timeLabelWidth, MyNextPasswordTimeLabelFont);
    _timeLabel.text = @"30秒后刷新";
    
    _serialCodeLabel.frame = CGRectMake(0.0f, _timeLabel.bottom + 10.0f, ScreenWidth, MyNextPasswordCodeLabelFont + 5.0f);
    
    CGFloat codeTitleWidth = [UIKitHelper getTextWidthWithText:@"你的下一个随机密码" andMaxHeight:MyNextPasswordTitleLabelFont andFont:[UIFont systemFontOfSize:MyNextPasswordTitleLabelFont]];
    _codeTitleLabel.frame = CGRectMake((ScreenWidth - codeTitleWidth)/2.0f, _serialCodeLabel.bottom + 10.0f, codeTitleWidth, MyNextPasswordTitleLabelFont);
    _codeTitleLabel.text = @"你的下一个随机密码";
    _refreshButton.frame = CGRectMake(_codeTitleLabel.right + 10.0f, _codeTitleLabel.top - 5.0f, 25.0f, 25.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
