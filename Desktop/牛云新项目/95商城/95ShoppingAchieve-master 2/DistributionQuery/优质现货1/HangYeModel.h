//
//  HangYeModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangYeModel : NSObject
#pragma mark --获取全部行业分类
@property(nonatomic,copy)NSString * HYname;
@property(nonatomic,copy)NSString * HYidd;
-(id)initWithHangYeAllDic:(NSDictionary*)dic;
@end
