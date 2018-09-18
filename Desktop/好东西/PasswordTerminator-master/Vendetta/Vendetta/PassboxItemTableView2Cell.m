//
//  PassboxItemTableView2Cell.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/16.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "PassboxItemTableView2Cell.h"

@implementation PassboxItemTableView2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableAttributedString *encodedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"明文密码 | %@",_item.encodedText]];
    [encodedStr setAttributes:[NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:14.0f],GlobalGray] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]] range:NSMakeRange(0, 7)];
    
    NSMutableAttributedString *usernameStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"用户名 | %@",_item.userName]];
    [usernameStr setAttributes:[NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:14.0f],GlobalGray] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]] range:NSMakeRange(0, 6)];
    
    _seperatorView.frame = CGRectMake(0.0f, self.height - 20.0f, ScreenWidth, 20.0f);
    
    CGFloat titleHeight = [UIKitHelper getTextHeightWithText:_item.passwordTitle andMaxWidth:self.width - 62.0f andFont:[UIFont boldSystemFontOfSize:20.0f]];
    _passwordTitleLabel.frame = CGRectMake(15.0f, 15.0f, self.width - 62.0f, titleHeight);
    _passwordCodeLabel.frame = CGRectMake(15.0f, _passwordTitleLabel.bottom + 10.0f, self.width - 30.0f, 23.0f);
    
    CGFloat linkHeight = [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"密码链接地址 | %@",_item.passwordLink] andMaxWidth:self.width - 30.0f andFont:[UIFont systemFontOfSize:14.0f]];
    _passwordLinkTextView.frame = CGRectMake(15.0f, _passwordCodeLabel.bottom + 10.0f, self.width - 30.0f, linkHeight);
    
    CGFloat usernameHeight = [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"用户名 | %@",_item.userName] andMaxWidth:self.width - 30.0f andFont:[UIFont systemFontOfSize:18.0f]];
    _passwordUsernameTextView.frame = CGRectMake(15.0f, _passwordLinkTextView.bottom + 10.0f, self.width - 30.0f, usernameHeight);
    
    _passwordTitleLabel.text = _item.passwordTitle;
    _passwordLinkTextView.text = [NSString stringWithFormat:@"密码链接地址 | %@",_item.passwordLink];
    _passwordUsernameTextView.attributedText = usernameStr;
    _passwordCodeLabel.attributedText = encodedStr;
    
    _deleteBtn.frame = CGRectMake(ScreenWidth - 47.0f, 15.0f, 32.0f, 32.0f);
}

- (void)initSubViews
{
    self.seperatorView = [[UIView alloc]initWithFrame:CGRectZero];
    _seperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_seperatorView];
    
    self.passwordTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    _passwordTitleLabel.textColor = [UIColor blackColor];
    _passwordTitleLabel.numberOfLines = 0;
    _passwordTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_passwordTitleLabel];
    
    self.passwordLinkTextView = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordLinkTextView.font = [UIFont systemFontOfSize:14.0f];
    _passwordLinkTextView.textColor = GlobalGray;
    [self.contentView addSubview:_passwordLinkTextView];
    
    self.passwordUsernameTextView = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordUsernameTextView.font = [UIFont systemFontOfSize:18.0f];
    _passwordUsernameTextView.textColor = GlobalNavGray;
    [self.contentView addSubview:_passwordUsernameTextView];
    
    self.passwordCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordCodeLabel.font = [UIFont systemFontOfSize:20.0f];
    _passwordCodeLabel.textColor = GlobalNavGray;
    [self.contentView addSubview:_passwordCodeLabel];
    
    self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_deleteBtn setTitle:@"✗" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_deleteBtn addTarget:self action:@selector(deleteItem) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
}

- (void)deleteItem
{
    if(self.deleteBlock)
    {
        self.deleteBlock(@(self.item.timestamp));
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
