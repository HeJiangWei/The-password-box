//
//  TPBase4Model.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCommonView4Helper.h"
#import "TPCommonDefine.h"
#import <YYCategories.h>
@interface TPBase4Model : NSObject

@property (nonatomic, strong) NSArray *items;


- (void)loadItems:(NSDictionary *)dict completion:(void(^)(NSDictionary *dic))completion failure:(void(^)(NSError *error))failure;

@end
