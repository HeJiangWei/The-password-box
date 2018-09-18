//
//  MyNextPasswordTableView2Cell.h
//  Vendetta
//
//  Created byjw chen JW on 15/8/16.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
 
@interface MyNextPasswordTableView2Cell : UITableViewCell

@property (nonatomic, strong) UIView *customBackgroundView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UILabel *serialCodeLabel;
@property (nonatomic, strong) UILabel *codeTitleLabel;

@property (nonatomic, copy) void (^refreshBlock)(void);
@end
