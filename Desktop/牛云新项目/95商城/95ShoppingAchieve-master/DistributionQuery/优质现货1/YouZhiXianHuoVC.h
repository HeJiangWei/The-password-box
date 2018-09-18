//
//  YouZhiXianHuoVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface YouZhiXianHuoVC : BaseViewController
/*
 如果tagg==10代表是特价专区进来的
 如果tagg==11代表是设备专区进来的
 如果tagg==12代表是物资专区进来的
 tagg==1的话就是本身(优质现货)
 */
@property(nonatomic,assign)NSInteger tagg;
@property(nonatomic,copy)NSString * ziText;
@end
