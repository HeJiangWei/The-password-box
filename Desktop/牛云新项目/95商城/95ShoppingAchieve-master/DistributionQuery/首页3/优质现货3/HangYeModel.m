//
//  HangYeModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/22.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "HangYeModel.h"

@implementation HangYeModel
#pragma mark --获取全部行业分类
-(id)initWithHangYeAllDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _HYname=[Tooljw0803Class isString:[dic objectForKey:@"Cate_CName"]];
        _HYidd=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Cate_Id"]]];
    }
    
    return self;
}
@end
