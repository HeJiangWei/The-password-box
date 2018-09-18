//
//  XiangQingVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface XiangQingVC : BaseViewController
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,copy)NSString * dianPuID;
/*
 tagg==1. 从优质现货>>店铺查看
 tagg==2,  最新采购详情页(没有进店查看，没有联系电话)
 tagg==3,从优质商户详情>>店铺查看 商品列表详情
 */
@property(nonatomic,assign)NSInteger tagg;

@end
