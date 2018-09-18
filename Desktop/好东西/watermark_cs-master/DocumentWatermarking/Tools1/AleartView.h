//
//  AleartView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AleartView : UIView

//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha;

//显示
-(void)show;
//消失
-(void)diss;

@end
