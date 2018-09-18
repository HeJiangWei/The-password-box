//
//  ChoosePeopleModel.h
//  DistributionQuery
//
//  Created by Macx on 16/11/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
//选择经济人Model
@interface ChoosePeopleModel : NSObject
@property(nonatomic,copy)NSString *headUrl;
@property(nonatomic,copy)NSString *bianHaoName;
@property(nonatomic,copy)NSString * ziyuanNumber;
@property(nonatomic,copy)NSString * jingJiIdd;
-(id)initWithChoosePeople:(NSDictionary*)dic;
@end
