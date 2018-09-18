//
//  DaShangPeopleIDModel.h
//  DistributionQuery
//
//  Created by Macx on 16/12/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaShangPeopleIDModel : NSObject
@property(nonatomic,copy)NSString * headImage;
@property(nonatomic,copy)NSString * nameLabel;
@property(nonatomic,copy)NSString * phoneLabel;
-(id)initWithDaShangPhone:(NSDictionary*)dic;
@end
