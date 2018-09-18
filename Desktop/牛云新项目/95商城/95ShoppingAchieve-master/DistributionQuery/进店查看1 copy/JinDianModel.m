//
//  JinDianModel.m
//  DistributionQuery
//
//  Created by Macx on 16/12/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "JinDianModel.h"

@implementation JinDianModel
-(id)initWithDiQuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]]];
         _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _diquName=[NSString stringWithFormat:@"%@-%@",[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]],[ToolClass isString:[dic objectForKey:@"C_City_Name"]]];
        
         _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
         _priceName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ExpectPrice"]]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
    }
    
    return self;
}
@end
