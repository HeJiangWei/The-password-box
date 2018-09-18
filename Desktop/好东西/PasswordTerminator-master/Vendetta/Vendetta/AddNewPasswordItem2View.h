//
//  AddNewPasswordItem2View.h
//  Vendetta
//
//  Created byjw chen JW on 15/8/21.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView2Ext.h"
#import "GlobalHeader.h"
#import "Password.pbobjc.h"
#import "CacheManager.h"

@interface AddNewPasswordItem2View : UIView

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UILabel *passwordTitleLabel;
@property (nonatomic, strong) UILabel *passwordLinkLabel;
@property (nonatomic, strong) UILabel *passwordUsernameLabel;
@property (nonatomic, strong) UILabel *passwordCodeLabel;

@property (nonatomic, strong) UITextField *passwordTitleTextField;
@property (nonatomic, strong) UITextField *passwordLinkTextField;
@property (nonatomic, strong) UITextField *passwordUsernameTextField;
@property (nonatomic, strong) UITextField *passwordCodeTextField;

@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, copy) void (^successBlock)(void);
@end
