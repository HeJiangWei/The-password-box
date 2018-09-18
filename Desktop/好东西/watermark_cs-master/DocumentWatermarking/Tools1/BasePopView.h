//
//  BasePopView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

//弹框视图的背景

#import <UIKit/UIKit.h>

@interface BasePopView : UIView

@property(nonatomic,assign)BOOL isBlurEffect;//是否模糊,默认否,当模糊的时候背景视图透明度无效无效
@property(nonatomic,strong)UIView *contentView;//内容视图
@property(nonatomic,assign)CGRect showRect;//显示的frame

//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha;
//子类需要重载
-(void)initView;

//显示
-(void)show;
//消失
-(void)diss;

@end
