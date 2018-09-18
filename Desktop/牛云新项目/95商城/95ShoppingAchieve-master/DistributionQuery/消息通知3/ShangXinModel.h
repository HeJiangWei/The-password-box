//
//  ShangXinModel.h
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangXinModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * time;
-(id)initWithShangXinDic:(NSDictionary*)dic;
@end
