//
//  JinDianModel.h
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JinDianModel : NSObject
@property(nonatomic,copy)NSString * imageview;
@property(nonatomic,copy)NSString * titleName;
@property(nonatomic,copy)NSString * diquName;
@property(nonatomic,copy)NSString * taishuName;
@property(nonatomic,copy)NSString * priceName;
@property(nonatomic,copy)NSString * messageID;
@property(nonatomic,assign)BOOL isTuo;
-(id)initWithDiQuDic:(NSDictionary*)dic;
@end
