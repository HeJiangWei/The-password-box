//
//  ShangXinjw0803Model.m
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "ShangXinjw0803Model.h"

@implementation ShangXinjw0803Model
-(id)initWithShangXinDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _title=[Tooljw0803Class isString:[dic objectForKey:@"N_Title"]];
        _time=[Tooljw0803Class isString:[dic objectForKey:@"N_Edit"]];
    }
    
    return self;
}
@end
