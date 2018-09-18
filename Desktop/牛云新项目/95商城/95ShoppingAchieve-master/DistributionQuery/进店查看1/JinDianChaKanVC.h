//
//  JinDianChaKanVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"
@interface JinDianChaKanVC : BaseViewController
/*
 tagg==1. 从优质现货>>店铺查看
 tagg==2, 优质商户详情页
 */
@property(nonatomic,assign)NSInteger tagg;
@property(nonatomic,strong)NSString * messageID;//产品ID
@end
