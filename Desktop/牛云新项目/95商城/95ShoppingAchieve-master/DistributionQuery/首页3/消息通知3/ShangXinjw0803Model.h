//
//  ShangXinjw0803Model.h
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangXinjw0803Model : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * time;
-(id)initWithShangXinDic:(NSDictionary*)dic;
@end
