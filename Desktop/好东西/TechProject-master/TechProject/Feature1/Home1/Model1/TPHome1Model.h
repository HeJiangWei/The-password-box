//
//  TPHome1Model.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPBaseModel.h"
#import "TPProject1Model.h"
#import "TPProjectRegionModel.h"
@interface TPHomeRegionItem: NSObject
@property (nonatomic, copy)NSString *regionName;
@property (nonatomic, strong) TPProjectRegionModel *region;
@end

@interface TPHome1Model : TPBaseModel

@end
