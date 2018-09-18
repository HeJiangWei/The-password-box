//
//  ImageShowView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageShowView;

typedef  void(^SelectBtnCall)(ImageShowView*imageScrollView);
typedef  void(^GrayClickCall)(ImageShowView*imageScrollView);

@interface ImageShowView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong)UIButton *backTopButton;//原图按钮

@property(nonatomic,assign)BOOL isSetImage;//是否设置了图片
@property(nonatomic,copy)SelectBtnCall selectBtnCall;
@property(nonatomic,copy)GrayClickCall grayClickCall;//显示选中灰色图层事件

@property(nonatomic,strong)UIView* showClickView;//显示点击拍照
@property(nonatomic,strong)UILabel* showLabel;//显示可缩放文字
@property(nonatomic,strong)UIView* showGrayView;//显示选中灰色图层

@property(nonatomic,strong)UIView* showSelectPhotoView;//选择相册

@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGest;//旋转手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGest;//捏合手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGest;//拖拽手势


/**
 //是否显示的是上面的图片,这个属性是为了统计用的,其余不用
 */
@property(nonatomic,assign)BOOL isTop;

- (instancetype)initWithFrame:(CGRect)frame andTakePhoto:(BOOL)isTakePhoto andSelectBlock:(SelectBtnCall)selectbtnCall;

////显示可旋转可缩放视图
//-(void)setshowLabel;
////显示点击拍照的视图
//-(void)setClickView:(NSString*)string;
//显示灰色视图
-(void)setGrayView;
////显示选择相册的视图
//-(void)setSelectPhotoView;

@end

