//
//  TPClientInfoEditVCL.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6ViewController.h"
#import "TPClientModel.h"
@interface TPClientInfoEditVCL : TPBase6ViewController
@property (nonatomic, strong) TPClientModel *client;
@property (nonatomic, copy) NSString *editType;
@property (nonatomic, copy) NSString *editValue;
@end
