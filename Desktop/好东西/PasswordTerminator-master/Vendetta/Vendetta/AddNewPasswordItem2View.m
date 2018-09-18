//
//  AddNewPasswordItem2View.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/21.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "AddNewPasswordItem2View.h"

@implementation AddNewPasswordItem2View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6.0f;
        
        CGFloat itemHeight = (self.height - 60.0f)/4.0f;
        
        self.passwordTitleLabel = [self labelForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, 15.0f, 75.0f, itemHeight) withTitle:@"密码项标题"];
        [self addSubview:_passwordTitleLabel];
        self.passwordTitleTextField = [self textFieldForFrame:CGRectMake(_passwordTitleLabel.right + 30.0f, _passwordTitleLabel.top, self.width - _passwordTitleLabel.right - 30.0f - ADD_VIEW_GLOBAL_LEFT_PADDING, itemHeight) withPlaceHolder:@"输入标题，例如“Github”"];
        [_passwordTitleTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_passwordTitleTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self addSubview:_passwordTitleTextField];
        
        [self addSubview:[self seperatorViewForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordTitleLabel.bottom, self.width - ADD_VIEW_GLOBAL_LEFT_PADDING * 2, 0.5f)]];
        
        self.passwordLinkLabel = [self labelForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordTitleLabel.bottom, 75.0f, itemHeight) withTitle:@"密码项链接"];
        [self addSubview:_passwordLinkLabel];
        self.passwordLinkTextField = [self textFieldForFrame:CGRectMake(_passwordLinkLabel.right + 30.0f, _passwordLinkLabel.top, self.width - _passwordLinkLabel.right - 30.0f - ADD_VIEW_GLOBAL_LEFT_PADDING, itemHeight) withPlaceHolder:@"输入Url，例如“www.github.com”"];
        [_passwordLinkTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_passwordLinkTextField setKeyboardType:UIKeyboardTypeURL];
        [_passwordLinkTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        
        [self addSubview:_passwordLinkTextField];
        
        [self addSubview:[self seperatorViewForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordTitleLabel.bottom, self.width - ADD_VIEW_GLOBAL_LEFT_PADDING * 2, 0.5f)]];
        
        self.passwordUsernameLabel = [self labelForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordLinkLabel.bottom, 75.0f, itemHeight) withTitle:@"使用用户名"];
        [self addSubview:_passwordUsernameLabel];
        self.passwordUsernameTextField = [self textFieldForFrame:CGRectMake(_passwordUsernameLabel.right + 30.0f, _passwordUsernameLabel.top, self.width - _passwordUsernameLabel.right - 30.0f - ADD_VIEW_GLOBAL_LEFT_PADDING, itemHeight) withPlaceHolder:@"输入用户名，例如“Vendetta”"];
        [_passwordUsernameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_passwordUsernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self addSubview:_passwordUsernameTextField];
        
        [self addSubview:[self seperatorViewForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordLinkLabel.bottom, self.width - ADD_VIEW_GLOBAL_LEFT_PADDING * 2, 0.5f)]];
        
        self.passwordCodeLabel = [self labelForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordUsernameLabel.bottom, 75.0f, itemHeight) withTitle:@"明文密码"];
        [self addSubview:_passwordCodeLabel];
        self.passwordCodeTextField = [self textFieldForFrame:CGRectMake(_passwordCodeLabel.right + 30.0f, _passwordCodeLabel.top, self.width - _passwordCodeLabel.right - 30.0f - ADD_VIEW_GLOBAL_LEFT_PADDING, itemHeight) withPlaceHolder:@"这里是你的明文密码"];
        _passwordCodeTextField.enabled = NO;
        _passwordCodeTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCode"];
        [self addSubview:_passwordCodeTextField];
        
        [self addSubview:[self seperatorViewForFrame:CGRectMake(ADD_VIEW_GLOBAL_LEFT_PADDING, _passwordUsernameLabel.bottom, self.width - ADD_VIEW_GLOBAL_LEFT_PADDING * 2, 0.5f)]];
        
        [self addSubview:[self seperatorViewForFrame:CGRectMake(_passwordTitleLabel.right + 20.0f, ADD_VIEW_GLOBAL_LEFT_PADDING, 0.5f, self.height - 60.0f)]];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 105.0f, self.height - 45.0f, 30.0f, 30.0f)];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"addItemCancel"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:GlobalGray forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_cancelButton];
        
        self.saveButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 60.0f, self.height - 45.0f, 30.0f, 30.0f)];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"addItemOk"] forState:UIControlStateNormal];
        [_saveButton setTitleColor:GlobalGray forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_saveButton];
    }
    return self;
}

- (void)cancelPressed:(id)sender
{
    if(self.cancelBlock)
    {
        self.cancelBlock();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)savePressed:(id)sender
{
    if([_passwordUsernameTextField.text isEqualToString:@""] || [_passwordTitleTextField.text isEqualToString:@""] || [_passwordLinkTextField.text isEqualToString:@""] || [_passwordCodeTextField.text isEqualToString:@""])
    {
        
    }
    else
    {
        PasswordItem *item = [[PasswordItem alloc]init];
        item.passwordTitle = _passwordTitleTextField.text;
        item.passwordLink = _passwordLinkTextField.text;
        item.userName = _passwordUsernameTextField.text;
        item.encodedText = _passwordCodeTextField.text;
        item.timestamp = (int64_t)[[NSDate date] timeIntervalSince1970];
        
        PasswordCache *cache = [[PasswordCache alloc]initWithData:[[CacheManager sharedInstance] getPasswordData] error:nil];
        [cache.itemsArray insertObject:item atIndex:0];
        [[CacheManager sharedInstance] savePasswordData:[cache data]];
        
        _passwordLinkTextField.text = @"";
        _passwordTitleTextField.text = @"";
        _passwordUsernameTextField.text = @"";
        
        if(self.successBlock)
        {
            self.successBlock();
        }
    }
}

- (UIView *)seperatorViewForFrame:(CGRect)frame
{
    UIView *tmp_seperator = [[UIView alloc]initWithFrame:frame];
    tmp_seperator.backgroundColor = GlobalGray;
    return tmp_seperator;
}

- (UILabel *)labelForFrame:(CGRect)frame withTitle:(NSString *)title
{
    UILabel *tmp_label = [[UILabel alloc]initWithFrame:frame];
    tmp_label.font = [UIFont systemFontOfSize:15.0f];
    tmp_label.textColor = GlobalNavGray;
    tmp_label.backgroundColor = [UIColor clearColor];
    tmp_label.textAlignment = NSTextAlignmentRight;
    tmp_label.text = title;
    return tmp_label;
}

- (UITextField *)textFieldForFrame:(CGRect)frame withPlaceHolder:(NSString *)placeHolder
{
    UITextField *tmp_textField = [[UITextField alloc]initWithFrame:frame];
    tmp_textField.textColor = [UIColor blackColor];
    tmp_textField.font = [UIFont systemFontOfSize:15.0f];
    tmp_textField.backgroundColor = [UIColor clearColor];
    tmp_textField.placeholder = placeHolder;
    return tmp_textField;
}
@end
