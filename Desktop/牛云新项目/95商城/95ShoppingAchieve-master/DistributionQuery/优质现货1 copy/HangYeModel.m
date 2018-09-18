//
//  HangYeModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HangYeModel.h"

@implementation HangYeModel
#pragma mark --获取全部行业分类
-(id)initWithHangYeAllDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _HYname=[ToolClass isString:[dic objectForKey:@"Cate_CName"]];
        _HYidd=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Cate_Id"]]];
    }
    
    return self;
}
@end
