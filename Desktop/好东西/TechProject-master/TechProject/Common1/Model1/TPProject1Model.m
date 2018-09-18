//
//  TPProject1Model.m
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/10.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPProject1Model.h"
#import "TPEncodeAndDecoded.h"
@implementation TPProject1Model
ENCODED_AND_DECODED()
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.infoArr = [NSMutableArray array];
    }
    return self;
}
@end
