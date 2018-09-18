//
//  StyleView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "StyleView.h"

@implementation StyleView
{
    UIButton *danBtn;//单面
    UIButton *shuangBtn;//双面
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setUI];
    }
    return self;
}

/*
 *  设置ui
 */
-(void)setUI{
    self.frame = CGRectMake(0, 5, kScreenWidth, 80);
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.image = [UIImage imageNamed:@"styleBg"];
    view.userInteractionEnabled = YES;
    [self addSubview:view];
    danBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    danBtn.frame = CGRectMake(20, 22, 33, 45);
    [danBtn setImage:[UIImage imageNamed:@"danmian"] forState:UIControlStateNormal];
    [danBtn setImage:[UIImage imageNamed:@"单面选中"] forState:UIControlStateSelected];
    danBtn.selected = YES;
    danBtn.tag = 1;
    [danBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:danBtn];
    
    shuangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shuangBtn.frame = CGRectMake(73, 22, 33, 45);
    [shuangBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [shuangBtn setImage:[UIImage imageNamed:@"shuangmian"] forState:UIControlStateNormal];
    [shuangBtn setImage:[UIImage imageNamed:@"双面选中"] forState:UIControlStateSelected];
    shuangBtn.tag = 2;
    [view addSubview:shuangBtn];
}

/*
 *  点击
 */
-(void)click:(UIButton*)btn{
    self.hidden = YES;
    danBtn.selected = NO;
    shuangBtn.selected = NO;
    btn.selected = YES;
    if (_selectBlock) {
        _selectBlock(btn.tag);
    }
}

/*
 *  显示
 */
-(void)show{
    self.hidden = NO;
}
-(void)hide{
    self.hidden = YES;
}


@end
