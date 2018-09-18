//
//  VersionUpDataView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VersionUpDataView : UIView

@property(nonatomic,strong)UILabel * updatePromptText;//升级功能点提示语

@property(nonatomic,copy)void(^updateAction)(void);
//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha;

//显示
-(void)show;
//消失
-(void)diss;

@end
