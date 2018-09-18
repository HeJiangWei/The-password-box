//
//  TPProjectModel.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPProjectModel.h"
#import "TPEncodeAndDecoded.h"
@implementation TPProjectModel
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
