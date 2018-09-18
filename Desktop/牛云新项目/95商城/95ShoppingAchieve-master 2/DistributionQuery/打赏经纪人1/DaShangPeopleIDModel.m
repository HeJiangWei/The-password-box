//
//  DaShangPeopleIDModel.m
//  DistributionQuery
//
//  Created by Macx on 16/12/22.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "DaShangPeopleIDModel.h"

@implementation DaShangPeopleIDModel
-(id)initWithDaShangPhone:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _headImage=[ToolClass isString:[dic objectForKey:@"U_Images"]];
        _nameLabel=[ToolClass isString:[dic objectForKey:@"U_RealName"]];
        _phoneLabel=[ToolClass isString:[dic objectForKey:@"U_PhoneNum"]];
    }
    
    return self;
}
@end
