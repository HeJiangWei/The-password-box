//
//  UIView+HTBorderLine.h
//  pangu
//
//  Created by King on 2017/8/7.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <UIKit/UIKit.h>



struct HTMargins {
    CGFloat left;
    CGFloat right;
};
typedef struct HTMargins HTMargins;

CG_INLINE HTMargins
HTMarginsMake(CGFloat left, CGFloat right)
{
    HTMargins p; p.left = left; p.right = right; return p;
}

@interface UIView (HTBorderLine)
/**
 设置view的底部阴影
 */
-(void)ht_bottomShadow;
/**
 设置view的顶部阴影
 */
-(void)ht_topShadow;

#pragma -mark-  topline
-(void)ht_topLineShow;
-(void)ht_topLineHidden;
-(void)ht_topLineLeftAndRightMargins:(HTMargins)point;
-(void)ht_topLineHeightUpdate:(CGFloat)height;
-(void)ht_topLineColorUpdate:(UIColor *)color;

#pragma -mark-  bottomline
-(void)ht_bottomLineShow;
-(void)ht_bottomLineHidden;
-(void)ht_bottomLineLeftAndRightMargins:(HTMargins)point;
-(void)ht_bottomLineHeightUpdate:(CGFloat)height;
-(void)ht_bottomLineColorUpdate:(UIColor *)color;

#pragma -mark-  rightline
-(void)ht_rightLineShow;
-(void)ht_rightLineHidden;
-(void)ht_rightLineTopAndBottomMargins:(HTMargins)point;
-(void)ht_rightLineHeightUpdate:(CGFloat)height;
-(void)ht_rightLineColorUpdate:(UIColor *)color;

#pragma -mark-  leftLine
-(void)ht_leftLineShow;
-(void)ht_leftLineHidden;
-(void)ht_leftLineTopAndBottomMargins:(HTMargins)point;
-(void)ht_leftLineHeightUpdate:(CGFloat)height;
-(void)ht_leftLineColorUpdate:(UIColor *)color;

#pragma -mark- 设置虚线
-(CAShapeLayer *)ht_creatDashedLayerSize:(CGSize)size;


@end
