//
//  UIView+HTBorderLine.m
//  pangu
//
//  Created by King on 2017/8/7.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "UIView+HTBorderLine.h"

static const void *HTViewTopLine = &HTViewTopLine;
static const void *HTViewBottomLine = &HTViewBottomLine;
static const void *HTViewRightLine = &HTViewRightLine;
static const void *HTViewLeftLine = &HTViewLeftLine;


@interface UIView()

@property (nonatomic,strong)UIView *topLine;

@property (nonatomic,strong)UIView *bottomLine;

@property (nonatomic,strong)UIView *rightLine;

@property (nonatomic,strong)UIView *leftLine;

@end

@implementation UIView (HTBorderLine)

/**
 设置view的底部阴影
 */
-(void)ht_bottomShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
}

/**
 设置view的顶部阴影
 */
-(void)ht_topShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,-1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
}



#pragma -mark-  topline
-(UIView *)topLine
{
    UIView *topLine = objc_getAssociatedObject(self, HTViewTopLine);
    if (topLine == nil) {
        topLine = [UIView new];
        topLine.backgroundColor = RGBHex(0xe1e1e1);
        [self addSubview:topLine];
        topLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewTopLine, topLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return topLine;
}


-(void)ht_topLineShow
{
    self.topLine.hidden = NO;
}

-(void)ht_topLineHidden
{
    self.topLine.hidden = YES;
}

-(void)ht_topLineLeftAndRightMargins:(HTMargins)point
{
    [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(point.left);
        make.right.equalTo(self).mas_offset(point.right);
    }];
    [self layoutIfNeeded];
}

-(void)ht_topLineHeightUpdate:(CGFloat)height
{
    [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self layoutIfNeeded];
}

-(void)ht_topLineColorUpdate:(UIColor *)color
{
    self.topLine.backgroundColor =color;
}





#pragma -mark-  bottomline
-(UIView *)bottomLine
{
    UIView *bottomLine = objc_getAssociatedObject(self, HTViewBottomLine);
    if (bottomLine == nil) {
        bottomLine = [UIView new];
        bottomLine.backgroundColor = RGBHex(0xe1e1e1);
        [self addSubview:bottomLine];
        bottomLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewBottomLine, bottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return bottomLine;
}


-(void)ht_bottomLineShow
{
    self.bottomLine.hidden = NO;
}

-(void)ht_bottomLineHidden
{
    self.bottomLine.hidden = YES;
}

-(void)ht_bottomLineLeftAndRightMargins:(HTMargins)point
{
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(point.left);
        make.right.equalTo(self).mas_offset(point.right);
    }];
}


-(void)ht_bottomLineHeightUpdate:(CGFloat)height
{
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self layoutIfNeeded];
}

-(void)ht_bottomLineColorUpdate:(UIColor *)color
{
    self.bottomLine.backgroundColor =color;
}



#pragma -mark-  rightline
-(UIView *)rightLine
{
    UIView *rightLine = objc_getAssociatedObject(self, HTViewRightLine);
    if (rightLine == nil) {
        rightLine = [UIView new];
        rightLine.backgroundColor = RGBHex(0xe1e1e1);
        [self addSubview:rightLine];
        rightLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewRightLine, rightLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(0.5);
        }];
    }
    return rightLine;
}


-(void)ht_rightLineShow
{
    self.rightLine.hidden = NO;
}

-(void)ht_rightLineHidden
{
    self.rightLine.hidden = YES;
}

-(void)ht_rightLineTopAndBottomMargins:(HTMargins)point
{
    [self.rightLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(point.left);
        make.bottom.equalTo(self).mas_offset(-point.right);
    }];
    [self layoutIfNeeded];
}

-(void)ht_rightLineHeightUpdate:(CGFloat)height
{
    [self.rightLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(height);
    }];
    [self layoutIfNeeded];
}

-(void)ht_rightLineColorUpdate:(UIColor *)color
{
    self.rightLine.backgroundColor =color;
}

#pragma -mark-  leftLine
-(UIView *)leftLine
{
    UIView *leftLine = objc_getAssociatedObject(self, HTViewLeftLine);
    if (leftLine == nil) {
        leftLine = [UIView new];
        leftLine.backgroundColor = RGBHex(0xe1e1e1);
        [self addSubview:leftLine];
        leftLine.hidden = YES;
        objc_setAssociatedObject(self, HTViewLeftLine, leftLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(0.5);
        }];
    }
    return leftLine;
}


-(void)ht_leftLineShow
{
    self.leftLine.hidden = NO;
}

-(void)ht_leftLineHidden
{
    self.leftLine.hidden = YES;
}

-(void)ht_leftLineTopAndBottomMargins:(HTMargins)point
{
    [self.leftLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(point.left);
        make.bottom.equalTo(self).mas_offset(-point.right);
    }];
    [self layoutIfNeeded];
}

-(void)ht_leftLineHeightUpdate:(CGFloat)height
{
    [self.leftLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(height);
    }];
    [self layoutIfNeeded];
}

-(void)ht_leftLineColorUpdate:(UIColor *)color
{
    self.leftLine.backgroundColor =color;
}






#pragma -mark- 设置虚线
-(CAShapeLayer *)ht_creatDashedLayerSize:(CGSize)size
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = RGBHex(0xe1e1e1).CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)].CGPath;
    border.frame = CGRectMake(0, 0, size.width, size.height);
    border.lineWidth = .5f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
    return border;
}




@end

