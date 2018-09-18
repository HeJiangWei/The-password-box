//
//  TPClientInfoEditVCL.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/22.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPBaseViewController.h"
#import "TPClient1Model.h"
@interface TPClientInfoEditVCL : TPBaseViewController
@property (nonatomic, strong) TPClient1Model *client;
@property (nonatomic, copy) NSString *editType;
@property (nonatomic, copy) NSString *editValue;
@end
