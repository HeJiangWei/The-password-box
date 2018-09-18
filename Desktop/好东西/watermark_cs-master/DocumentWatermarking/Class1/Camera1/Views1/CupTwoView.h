//
//  CupTwoView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageShowView.h"

@interface CupTwoView : UIView
@property (nonatomic,strong) UIBezierPath *cupBezPath;
@property (nonatomic,strong) UIBezierPath *cupBezPath2;//第二个显示路径
@property(nonatomic,strong) ImageShowView *shwoView;
@property(nonatomic,strong) ImageShowView *shwoView2;//第二个显示框


@property(nonatomic,strong)UIImageView *largeView;//显示一张图片
@property(nonatomic,strong)UIImageView *largeBottomView;//显示另一张图片


@property (nonatomic,strong) UIColor *lineColor;        //边线颜色
@property (nonatomic,assign) CGFloat lineWidth;         //边线宽度
@property (nonatomic,assign) CGRect WillCupRect;        //剪切区域
@property (nonatomic,assign) CGRect WillCupRect2;        //第二个剪切区域

@property(nonatomic,copy)void(^takePhotoBlack)(ImageShowView*shwoView,BOOL first);


@end

