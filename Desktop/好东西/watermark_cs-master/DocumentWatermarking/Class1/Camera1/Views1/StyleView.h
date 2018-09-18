//
//  StyleView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleView : UIView

@property(nonatomic,copy)void(^selectBlock)(NSInteger index);

/*
 *  显示
 */
-(void)show;
-(void)hide;
@end
