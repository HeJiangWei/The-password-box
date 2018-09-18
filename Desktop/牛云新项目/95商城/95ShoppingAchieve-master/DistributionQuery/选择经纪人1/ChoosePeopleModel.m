//
//  ChoosePeopleModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChoosePeopleModel.h"

@implementation ChoosePeopleModel
-(id)initWithChoosePeople:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _headUrl=[ToolClass isString:[dic objectForKey:@"U_Images"]];
         _bianHaoName=[ToolClass isString:[dic objectForKey:@"U_Name"]];
         _ziyuanNumber=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"U_Count"]]];
         _jingJiIdd=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"U_Id"]]];
    }
    
    return self;
}
@end
