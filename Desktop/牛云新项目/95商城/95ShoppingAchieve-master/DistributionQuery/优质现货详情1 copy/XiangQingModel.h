//
//  XiangQingModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiangQingModel : NSObject
//轮播图
@property(nonatomic,strong)NSArray * imageArr;//现在没有轮播就有一张图片先用图片表示
@property(nonatomic,copy)NSString *imagename;
@property(nonatomic,copy)NSString*titleName;
@property(nonatomic,copy)NSString* priceName;
@property(nonatomic,copy)NSString*bianHaoName;
@property(nonatomic,copy)NSString * phoneName;
//具体参数
@property(nonatomic,copy)NSString * xinagHaoName;
@property(nonatomic,copy)NSString * chanDiName;
@property(nonatomic,copy)NSString * shuLiangName;
@property(nonatomic,copy)NSString * suozaiDiName;
//详细信息
@property(nonatomic,copy)NSString * xiangXiName;


//优质现货详情
-(id)initWithXiangXiDic:(NSDictionary*)dic;


//最新采购详情
-(id)initWithZuiXinCiGouXiangXiDic:(NSDictionary*)dic;



//猜你喜欢自己的数据
@property(nonatomic,copy)NSString * caiimage;
@property(nonatomic,copy)NSString * caititle;
@property(nonatomic,copy)NSString * caiaddress;
@property(nonatomic,copy)NSString * caitaishu;
@property(nonatomic,copy)NSString * caiprice;
-(id)initWithCaiNiLikeDic:(NSDictionary*)dic;
@end
