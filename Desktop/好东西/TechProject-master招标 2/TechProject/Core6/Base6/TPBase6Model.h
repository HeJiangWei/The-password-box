//
//  TPBase6Model.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPCommonView6Helper.h"
#import "TPCommon6Define.h"
#import <YYCategories.h>
@interface TPBase6Model : NSObject

@property (nonatomic, strong) NSArray *items;


- (void)loadItems:(NSDictionary *)dict completion:(void(^)(NSDictionary *dic))completion failure:(void(^)(NSError *error))failure;

@end
