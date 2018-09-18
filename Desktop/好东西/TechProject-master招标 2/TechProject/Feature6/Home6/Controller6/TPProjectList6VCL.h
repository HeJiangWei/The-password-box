//
//  TPProjectList6VCL.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6ViewController.h"
#import "TPProjectModel.h"
#import "TPProjectRegionModel.h"
#import "TPBarItem.h"
@interface TPProjectList6VCL : TPBase6ViewController
@property (nonatomic, strong) TPProjectRegionModel *region;
- (void)reloadData:(TPBarItem *)item;
@end
