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
        _headUrl=[Tooljw0803Class isString:[dic objectForKey:@"U_Images"]];
         _bianHaoName=[Tooljw0803Class isString:[dic objectForKey:@"U_Name"]];
         _ziyuanNumber=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"U_Count"]]];
         _jingJiIdd=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"U_Id"]]];
    }
    
    return self;
}
@end
