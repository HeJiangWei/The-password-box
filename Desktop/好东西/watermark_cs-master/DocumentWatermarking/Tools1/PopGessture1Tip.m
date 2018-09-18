//
//  PopGessture1Tip.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PopGessture1Tip.h"

@interface PopGessture1Tip()
@property(nonatomic,strong)UIView *effectView;//模糊视图
@property(nonatomic,assign)BOOL isEffect;//是否已经模糊
@property(nonatomic,assign)CGFloat alpha;//显示的透明度
@property(nonatomic,assign)CGRect showRect;//显示的frame
@property(nonatomic,strong)UIView *contentView;//内容视图

@end

@implementation PopGessture1Tip
-(instancetype)initWithShowFrame:(CGRect)frame andAlpha:(CGFloat)bgAlpha{
    self = [super init];
    if (self) {
        _alpha = bgAlpha;
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:_alpha];
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
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"手势示意图" withExtension:@"gif"];//加载GIF图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);//将GIF图片转换成对应的图片源
    size_t frameCout=CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
    NSMutableArray* frames=[[NSMutableArray alloc] init];//定义数组存储拆分出来的图片
    for (size_t i=0; i<frameCout;i++){
        CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
        UIImage* imageName=[UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
        [frames addObject:imageName];//将图片加入数组中
        CGImageRelease(imageRef);
    }
    
    CGFloat height = (kScreenWidth-76-77)*216/221;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(77, (kScreenHeight-height)/2.0, kScreenWidth-77-76, height)];
    imageView.animationImages = frames;//将图片数组加入UIImageView动画数组中
    imageView.animationDuration = 6;//每次动画时长
    [imageView startAnimating];//开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    [self addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreenWidth-50)/2, kScreenHeight - 120, 50, 25);
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //6秒后执行消失
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0/*延迟执行时间*/ * NSEC_PER_SEC));
    WeakSelf;
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf diss];
    });
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
