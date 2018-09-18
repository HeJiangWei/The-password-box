//
//  TPClientInfoEditVCL.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/22.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4ViewController.h"
#import "TPClientModel.h"
@interface TPClientInfoEditVCL : TPBase4ViewController
@property (nonatomic, strong) TPClientModel *client;
@property (nonatomic, copy) NSString *editType;
@property (nonatomic, copy) NSString *editValue;
@end
