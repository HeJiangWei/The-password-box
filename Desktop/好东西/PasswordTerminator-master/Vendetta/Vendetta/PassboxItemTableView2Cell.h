//
//  PassboxItemTableView2Cell.h
//  Vendetta
//
//  Created byjw chen JW on 15/8/16.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "UIView2Ext.h"
#import "Password.pbobjc.h"
#import "UIKit+Helper.h"

@interface PassboxItemTableView2Cell : UITableViewCell

@property (nonatomic, strong) UIView *seperatorView;
@property (nonatomic, strong) PasswordItem *item;

@property (nonatomic, strong) UILabel *passwordTitleLabel;
@property (nonatomic, strong) UILabel *passwordLinkTextView;
@property (nonatomic, strong) UILabel *passwordUsernameTextView;
@property (nonatomic, strong) UILabel *passwordCodeLabel;

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, copy) void (^deleteBlock)(id itemTimestamp);
@end
