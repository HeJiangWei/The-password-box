//
//  ScanCodeVC.h
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "Basejw0803ViewController.h"
#import "GuanLiModel.h"
@interface ScanCodeVC : Basejw0803ViewController
/*
 tagg==2的时候代表是从管理修改过来的
 */
@property(nonatomic,assign)NSInteger tagg;
@property(nonatomic,strong)GuanLiModel * model;
@end
