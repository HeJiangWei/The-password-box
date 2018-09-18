//
//  HomeModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
#pragma mark --特价专区Model
@property (nonatomic,copy)NSString * imageview;
@property (nonatomic,copy)NSString * titleName;
@property (nonatomic,copy)NSString * priceName;
@property (nonatomic,copy)NSString * cityName;
@property (nonatomic,copy)NSString * taishuName;
@property(nonatomic,copy)NSString * sheBeiName;
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,assign)BOOL isTuo;
-(id)initWithTeJiaDic:(NSDictionary*)dic;

//优质现货  (dianpuID店铺ID，从现货详情页进入店铺查看需要。messageID从先货进入详情页需要) 现货专用
@property(nonatomic,copy)NSString * dianpuID;
-(id)initWithYouZhiXianHuoDic:(NSDictionary*)dic;
@property(nonatomic,copy)NSString * phoneNumber;
//优质商户
-(id)initWithYouZhiShangHuDic:(NSDictionary*)dic;



//(收藏采购)
-(id)initWithCaiGouDic:(NSDictionary*)dic;

////最新采购
-(id)initWithZuiXinCaiGouDic:(NSDictionary*)dic;
@end
