//
//  PopClickView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PopClickView.h"
@interface PopClickView()

@property(nonatomic,strong)UIView *effectView;//模糊视图
@property(nonatomic,assign)BOOL isEffect;//是否已经模糊
@property(nonatomic,assign)CGFloat alpha;//显示的透明度
@property(nonatomic,assign)CGRect showRect;//显示的frame
@property(nonatomic,strong)UIView *contentView;//内容视图

@end

@implementation PopClickView

//设置一个背景透明度为alpha的视图
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha{
    self = [super init];
    if (self) {
        _showRect = frame;
        _alpha = bgAlpha;
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:_alpha];
//        [self addSubview:self.effectView];
//        [self addSubview:self.contentView];
        [self initView];
    }
    return self;

}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, _showRect.size.height)];
        //        _contentView.userInteractionEnabled = NO;
    }
    return _contentView;
}

/*
 *  初始化界面
 */
-(void)initView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, (kScreenHeight-219)/2.0, kScreenWidth-80, 219)];
    ViewRadius(view, 5);
    view.backgroundColor = [UIColor clearColor];
    
    UIView * view1 = [[UIView alloc]initWithFrame:view.bounds];
    ViewRadius(view1, 5);
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    [view addSubview:view1];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(view.bounds.size.width-50, 15, 40, 40);
    [cancelBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, view.bounds.size.width-20, 100)];
    _label.numberOfLines = 1;
    _label.font = [UIFont systemFontOfSize:24];

    if (kScreenWidth == 320 && kScreenHeight == 568) {
        //使5s尺寸设备的文字能够显示
        _label.font = [UIFont systemFontOfSize:18];
    }
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_label];
    
    CGFloat btnW = (view.bounds.size.width-30-25)/2.0;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, view.bounds.size.height-65, btnW, 45);
    btn.backgroundColor = [UIColor colorWithHexString:@"#0373F6"];
    [btn setTitle:@"立即分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(btn, 3);
    [view addSubview:btn];

    UIButton *nobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nobtn.frame = CGRectMake(15+25+btnW, view.bounds.size.height-65, btnW, 45);
    nobtn.backgroundColor = [UIColor colorWithHexString:@"#9B9B9B"];
    [nobtn setTitle:@"暂不分享" forState:UIControlStateNormal];
    [nobtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nobtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(nobtn, 3);
    [view addSubview:nobtn];
    
    [self addSubview:view];
    
}

-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
//    CGRect frame = self.contentView.frame;
//    frame.origin.y -= self.contentView.frame.size.height;
//    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.contentView.frame = frame;
//
//    } completion:^(BOOL finished) {
//
//    }];
//
    
}

-(void)diss{
    
//    CGRect frame = self.contentView.frame;
//    frame.origin.y += self.contentView.frame.size.height;
//
//    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.contentView.frame = frame;
        [self removeSubviews];
        
//    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//    }];
    
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

/*
 *  share
 */
-(void)share{
    [self diss];
    if (_shareAction) {
        _shareAction();
    }
}



@end
