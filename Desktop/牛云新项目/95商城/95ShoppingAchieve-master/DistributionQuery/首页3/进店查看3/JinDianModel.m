//
//  JinDianModel.m
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "JinDianModel.h"

@implementation JinDianModel
-(id)initWithDiQuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]]];
         _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        _diquName=[NSString stringWithFormat:@"%@-%@",[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]],[Tooljw0803Class isString:[dic objectForKey:@"C_City_Name"]]];
        
         _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
         _priceName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ExpectPrice"]]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
        if ([[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Agent"]]] isEqualToString:@"0"]) {
            _isTuo=NO;
        }else{
            _isTuo=YES;
        }

    }
    
    return self;
}
@end
