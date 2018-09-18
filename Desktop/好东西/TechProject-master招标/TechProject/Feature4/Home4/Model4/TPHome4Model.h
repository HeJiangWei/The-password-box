//
//  TPHome4Model.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4Model.h"
#import "TPProjectModel.h"
#import "TPProjectRegionModel.h"
@interface TPHomeRegionItem: NSObject
@property (nonatomic, copy)NSString *regionName;
@property (nonatomic, strong) TPProjectRegionModel *region;
@end

@interface TPHome4Model : TPBase4Model

@end
