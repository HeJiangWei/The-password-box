//
//  Define.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kRatioH kScreenHeight/kScreenWidth
#define kRatioW kScreenWidth/kScreenHeight

//比例
#define SCALE_HEIGHT_TOCURRENTIPHONE  SCREEN_Height/667
#define SCALE_WIDTH_TOCURRENTIPHONE  SCREEN_Width/375

#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0f)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0f)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)

#define kDeviceScale [UIScreen mainScreen].scale

#define kwaterMarkFrameMultiple  3   //水印拖动放大的倍数

#ifdef DEBUG
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

#define WeakSelf    __weak typeof(self) weakSelf = self
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define kShareSuccess @"shareSuccess"
#define kTipGessShow @"tipGessShow"
#define kLaunchTimeShow @"launchAppTime"
#define kWaterMarkModel @"kWaterMarkModel"
#define kAleartViewShow @"aleartViewShow"
#define kAdvanceCount @"advanceCount"

#endif /* Define_h */
