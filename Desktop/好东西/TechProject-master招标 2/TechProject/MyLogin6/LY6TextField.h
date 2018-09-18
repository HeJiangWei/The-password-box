//
//  LY6TextField.h
//  自定义登录界面
//
//  Created by apple1 on 16/8/10.
//  Copyright © 2016年 90909. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LY6TextField : UIView

//注释信息
@property (nonatomic,copy) NSString *ly_placeholder;

//光标颜色
@property (nonatomic,strong) UIColor *cursorColor;

//注释普通状态下颜色
@property (nonatomic,strong) UIColor *placeholderNormalStateColor;

//注释选中状态下颜色
@property (nonatomic,strong) UIColor *placeholderSelectStateColor;


//文本框
@property (nonatomic,strong) UITextField *textField;
@end
