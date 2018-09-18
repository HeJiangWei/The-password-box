//
//  BasePopView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BasePopView.h"


@interface BasePopView()

@property(nonatomic,strong)UIView *effectView;//模糊视图
@property(nonatomic,assign)BOOL isEffect;//是否已经模糊
@property(nonatomic,assign)CGFloat alpha;//显示的透明度
@end

@implementation BasePopView

-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha
{
    self = [super init];
    if (self) {
        _showRect = frame;
        _alpha = bgAlpha;
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:_alpha];
        [self addSubview:self.effectView];
        [self addSubview:self.contentView];
        [self initView];
    }
    return self;
}

//子类去重写
-(void)initView{
    
}

//背景模糊视图
-(UIView *)effectView{
    if (!_effectView) {
        _effectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diss)];
        _effectView.userInteractionEnabled = YES;
        [_effectView addGestureRecognizer:tap];
    }
    return _effectView;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, _showRect.size.height)];
//        _contentView.userInteractionEnabled = NO;
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

//设置模糊
-(void)setIsBlurEffect:(BOOL)isBlurEffect{
    if (isBlurEffect&&!_isEffect) {
        _isEffect = YES;
        _alpha = 1;
        /***************添加模糊效果***************/
        // 1.创建模糊view
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        // 2.设定模糊View的尺寸
        effectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        // 3.添加到view当中
        [_effectView addSubview:effectView];
    }
}

-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];

    CGRect frame = self.contentView.frame;
    frame.origin.y -= self.contentView.frame.size.height;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.contentView.frame = frame;

    } completion:^(BOOL finished) {

    }];

    
}

-(void)diss{
    
    CGRect frame = self.contentView.frame;
    frame.origin.y += self.contentView.frame.size.height;

    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = frame;
        [self removeSubviews];

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)removeSubviews {
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
