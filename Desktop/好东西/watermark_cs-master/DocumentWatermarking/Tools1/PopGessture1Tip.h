//
//  PopGessture1Tip.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopGessture1Tip : UIView
@property(nonatomic,copy)void(^shareAction)(void);
//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha;

//显示
-(void)show;
//消失
-(void)diss;

@end
