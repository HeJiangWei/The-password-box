//
//  TPProjectListVCL.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/10.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4ViewController.h"
#import "TPProjectModel.h"
#import "TPProjectRegionModel.h"
#import "TPBarItem.h"
@interface TPProjectListVCL : TPBase4ViewController
@property (nonatomic, strong) TPProjectRegionModel *region;
- (void)reloadData:(TPBarItem *)item;
@end
