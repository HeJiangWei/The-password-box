//
//  TPBase4Model.m
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4Model.h"

@implementation TPBase4Model

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}


- (void)loadItems:(NSDictionary *)dict completion:(void(^)(NSDictionary *dic))completion failure:(void(^)(NSError *error))failure{
    
}
@end
