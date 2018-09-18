//
//  GuanLiModel.h
//  DistributionQuery
//
//  Created by Macx on 16/12/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuanLiModel : NSObject
@property(nonatomic,copy)NSString * titleName;//标题
@property(nonatomic,copy)NSString * nikeName;//名称
@property(nonatomic,copy)NSString * numName;//数量
@property(nonatomic,copy)NSString * xingHaoName;//型号
@property(nonatomic,copy)NSString * priceName;//价格
@property(nonatomic,copy)NSString * addressName;//产地
@property(nonatomic,copy)NSString * chengseName;//成色
@property(nonatomic,copy)NSString * chengseCode;//成色
@property(nonatomic,copy)NSString * xiangXiName;//描述

@property(nonatomic,copy)NSString * imageurl;//图片整机
@property(nonatomic,copy)NSString * imageurl2;//单张图片

@property(nonatomic,copy)NSString * jingjiID;//经纪人ID

@property(nonatomic,copy)NSString * chaKan;//查看次数
@property(nonatomic,copy)NSString * messageID;//信息ID
-(id)initWithGuanLiDic:(NSDictionary*)dic;
@end
