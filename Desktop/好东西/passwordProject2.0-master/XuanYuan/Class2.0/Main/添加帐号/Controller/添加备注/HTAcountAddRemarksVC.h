//
//  HTAcountAddRemarksVC.h
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/23.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYBaseViewController.h"

@interface HTAcountAddRemarksVC : XYBaseViewController

@property (nonatomic,copy) NSString * defaultText;

@property (nonatomic, copy) void(^clickedFinish)(NSString *text);

@end
