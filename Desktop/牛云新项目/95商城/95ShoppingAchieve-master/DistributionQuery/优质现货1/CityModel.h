//
//  CityModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
#pragma mark --省份解析
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString * shengCode;
-(id)initWithShengDic:(NSDictionary*)dic;
#pragma mark --城市解析
@property(nonatomic,copy)NSString * cityName;
@property(nonatomic,copy)NSString * cityCode;
@property(nonatomic,copy)NSString * cityShengCode;
-(id)initWithCityDic:(NSDictionary*)dic;
@end
