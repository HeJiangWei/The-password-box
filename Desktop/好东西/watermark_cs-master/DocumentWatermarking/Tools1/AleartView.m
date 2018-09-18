//
//  AleartView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AleartView.h"

@interface AleartView()
@property(nonatomic,strong)UIView *effectView;//模糊视图
@property(nonatomic,assign)CGFloat alpha;//显示的透明度
@property(nonatomic,assign)CGRect showRect;//显示的frame
@property(nonatomic,strong)UIView *contentView;//内容视图

@end

@implementation AleartView

-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha{
    self = [super init];
    if (self) {
        _alpha = bgAlpha;
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:_alpha];
        _showRect = frame;
        //        [self addSubview:self.effectView];
        //        [self addSubview:self.contentView];
        [self initView];
    }
    return self;
    
}

/*
 *  init
 */
-(void)initView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-172), _showRect.origin.y, 160, 50);
    [btn setTitle:@"隐藏水印，可拖动照片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-8, 0, 0, 0)];
    [btn setBackgroundImage:[UIImage imageNamed:@"提示背景框"] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
//    3秒后执行消失
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));
    WeakSelf;
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf diss];
    });
    
}

-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
}

-(void)diss{
    
    [self removeSubviews];
    [self removeFromSuperview];
    
}

- (void)removeSubviews {
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

/*
 *  取消
 */
-(void)cancle{
    [self diss];
}



@end
