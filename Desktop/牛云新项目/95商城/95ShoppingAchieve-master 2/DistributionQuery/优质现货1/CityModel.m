//
//  CityModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
#pragma mark --省份解析
-(id)initWithShengDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {//p_sname是不带市，p_name带市或者省
        _shengName=[dic objectForKey:@"p_sname"];
        _shengCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"p_code"]];
    }
    
    return self;
}
#pragma mark --城市解析
-(id)initWithCityDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _cityName=[dic objectForKey:@"c_name"];
        _cityCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"c_code"]];
        _cityShengCode=[NSString stringWithFormat:@"%@",[dic objectForKey:@"c_pid"]];
    }
    
    return self;
}
@end
