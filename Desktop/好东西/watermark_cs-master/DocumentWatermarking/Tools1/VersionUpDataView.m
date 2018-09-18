//
//  VersionUpDataView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "VersionUpDataView.h"
@interface VersionUpDataView()

@property(nonatomic,strong)UIView *effectView;//模糊视图
@property(nonatomic,assign)BOOL isEffect;//是否已经模糊
@property(nonatomic,assign)CGFloat alpha;//显示的透明度
@property(nonatomic,assign)CGRect showRect;//显示的frame
@property(nonatomic,strong)UIView *contentView;//内容视图

@end

@implementation VersionUpDataView

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
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    ViewRadius(view, 5);
    view.backgroundColor = [UIColor clearColor];
    
    UIView * view1 = [[UIView alloc]initWithFrame:view.bounds];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.7;
    [view addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(50, (kScreenHeight - (kScreenWidth - 100)/275 * 385)/2 - 20, kScreenWidth - 100, (kScreenWidth - 100)/275 * 385)];
    view2.backgroundColor = [UIColor clearColor];
    [view addSubview:view2];
    
    UIImageView * updataImageView = [[UIImageView alloc]initWithFrame:view2.bounds];
    updataImageView.image = [UIImage imageNamed:@"updateAppPage"];
    [view2 addSubview:updataImageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, view2.bounds.size.height/2, view2.bounds.size.width-30, 30)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"升级到最新版本";
    label.textColor = [UIColor colorWithHexString:@"9B9B9B"];
    label.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:label];
    
    
    self.updatePromptText = [[UILabel alloc]initWithFrame:CGRectMake(15, view2.bounds.size.height/2 + 38, view2.bounds.size.width-30, 30)];
//    self.updatePromptText = [UILabel new];
    self.updatePromptText.font = [UIFont systemFontOfSize:14];
    self.updatePromptText.textColor = [UIColor colorWithHexString:@"BEBEBE"];
    self.updatePromptText.numberOfLines = 0;
    self.updatePromptText.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:self.updatePromptText];

    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(2, view2.frame.size.height - 66, view2.frame.size.width - 4, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"BEBEBE"];
    [view2 addSubview:line];
    
    CGFloat btnW = (view2.bounds.size.width)/2.0;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, view2.bounds.size.height-60, btnW, 45);
    //    btn.backgroundColor = [UIColor colorWithHexString:@"#0373F6"];
    [btn setTitle:@"暂不升级" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"BEBEBE"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(btn, 3);
    [view2 addSubview:btn];
    
    UIButton *nobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nobtn.frame = CGRectMake(btnW, view2.bounds.size.height-60, btnW, 45);
    //    nobtn.backgroundColor = [UIColor colorWithHexString:@"#9B9B9B"];
    [nobtn setTitle:@"立即升级" forState:UIControlStateNormal];
    [nobtn setTitleColor:[UIColor colorWithHexString:@"0373F6"] forState:UIControlStateNormal];
    [nobtn addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(nobtn, 3);
    [view2 addSubview:nobtn];
    
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
    //  [MobClick event:@"version_reject"];
    [self diss];
}

/*
 *  share
 */
-(void)update{
    
    //  [MobClick event:@"version_accept"];
    if (_updateAction) {
        _updateAction();
    }
}

@end
