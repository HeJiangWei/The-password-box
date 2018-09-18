//
//  XiangQingModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiangQingModel.h"

@implementation XiangQingModel
//详情信息
-(id)initWithXiangXiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]]];
        _imagename=image;
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ExpectPrice"]]];
        _bianHaoName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ProductCode"]]];
        _phoneName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_MobieNum"]]];
        //具体参数
        _xinagHaoName=[ToolClass isString:[dic objectForKey:@"C_Type"]];
        NSString * chanSheng =[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        NSString * chashi =[ToolClass isString:[dic objectForKey:@"C_Class"]];
        _chanDiName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ProductLocation"]]];
        _shuLiangName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _suozaiDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        //详细信息
        _xiangXiName=[ToolClass isString:[dic objectForKey:@"C_Description"]];
        
        
    }
    
    return self;
}
//最新采购详情
-(id)initWithZuiXinCiGouXiangXiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _imagename =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_Pics"]]];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Name"]];
        _priceName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Price"]]];
        _bianHaoName=@"123459";
       //具体型号
        NSString * chanSheng =[ToolClass isString:[dic objectForKey:@"PName"]];
        NSString * chashi =[ToolClass isString:[dic objectForKey:@"CName"]];
        _chanDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        _shuLiangName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _suozaiDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        _xinagHaoName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Cid"]]];
        //详细信息
        _xiangXiName=[ToolClass isString:[dic objectForKey:@"C_Content"]];
        
        
    }
    
    return self;
}




//猜你喜欢数据
-(id)initWithCaiNiLikeDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _caiimage=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]]];
         _caititle=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        NSString * sheng =[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        NSString * shi =[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
         _caiaddress=[NSString stringWithFormat:@"%@-%@",sheng,shi];
         _caitaishu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
         _caiprice=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
    }
    
    return self;
}


@end
