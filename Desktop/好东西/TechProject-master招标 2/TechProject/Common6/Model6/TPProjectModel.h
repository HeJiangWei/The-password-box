//
//  TPProjectModel.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPProjectRegionModel.h"
@interface TPProjectModel : NSObject
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, strong) TPProjectRegionModel *region;
@end


