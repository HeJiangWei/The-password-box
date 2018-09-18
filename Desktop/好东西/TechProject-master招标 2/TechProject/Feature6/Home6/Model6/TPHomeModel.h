//
//  TPHomeModel.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6Model.h"
#import "TPProjectModel.h"
#import "TPProjectRegionModel.h"
@interface TPHomeRegionItem: NSObject
@property (nonatomic, copy)NSString *regionName;
@property (nonatomic, strong) TPProjectRegionModel *region;
@end

@interface TPHomeModel : TPBase6Model

@end
