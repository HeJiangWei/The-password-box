//
//  ScanCodeVC.h
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"
#import "GuanLiModel.h"
@interface ScanCodeVC : BaseViewController
/*
 tagg==2的时候代表是从管理修改过来的
 */
@property(nonatomic,assign)NSInteger tagg;
@property(nonatomic,strong)GuanLiModel * model;
@end
