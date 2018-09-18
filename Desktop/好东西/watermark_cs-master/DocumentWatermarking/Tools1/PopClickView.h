//
//  PopClickView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./22.
//  Copyright © 2017年 apple. All rights reserved.
//

//弹出是否分享的视图
#import <UIKit/UIKit.h>

@interface PopClickView : UIView
@property(nonatomic,copy)void(^shareAction)(void);
@property(nonatomic,strong) UILabel *label;

//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha;

//显示
-(void)show;
//消失
-(void)diss;

@end
