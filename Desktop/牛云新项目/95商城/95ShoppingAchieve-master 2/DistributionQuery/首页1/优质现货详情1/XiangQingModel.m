//
//  XiangQingModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiangQingModel.h"

@implementation XiangQingModel
//优质现货详情信息
-(id)initWithXiangXiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]]];
        _imagename=image;
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        _priceName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ExpectPrice"]]];
        _bianHaoName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ProductCode"]]];
        _phoneName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_MobieNum"]]];//E_Number
        //具体参数
        _xinagHaoName=[Tooljw0803Class isString:[dic objectForKey:@"C_Type"]];
        NSString * chanSheng =[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]];
        NSString * chashi =[Tooljw0803Class isString:[dic objectForKey:@"C_Class"]];
        _chanDiName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_ProductLocation"]]];
        _shuLiangName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _suozaiDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        //详细信息
        _xiangXiName=[Tooljw0803Class isString:[dic objectForKey:@"C_Description"]];
        
        
    }
    
    return self;
}

//只是为了在Item3中取出电话,在Item4中没法取出
-(id)initWithXiangXiPhoneDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _phoneName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"E_Number"]]];//E_Number
    }
    
    return self;
}





//最新采购详情
-(id)initWithZuiXinCiGouXiangXiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _imagename =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_Pics"]]];
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Name"]];
        _priceName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Price"]]];
        _bianHaoName=@"123459";
       //具体型号
        NSString * chanSheng =[Tooljw0803Class isString:[dic objectForKey:@"PName"]];
        NSString * chashi =[Tooljw0803Class isString:[dic objectForKey:@"CName"]];
        _chanDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        _shuLiangName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _suozaiDiName=[NSString stringWithFormat:@"%@-%@",chanSheng,chashi];
        _xinagHaoName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Cid"]]];
        //详细信息
        _xiangXiName=[Tooljw0803Class isString:[dic objectForKey:@"C_Content"]];
        
        
    }
    
    return self;
}




//猜你喜欢数据
-(id)initWithCaiNiLikeDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _caiimage=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]]];
         _caititle=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        NSString * sheng =[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]];
        NSString * shi =[Tooljw0803Class isString:[dic objectForKey:@"C_City_Name"]];
         _caiaddress=[NSString stringWithFormat:@"%@-%@",sheng,shi];
         _caitaishu=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
         _caiprice=[Tooljw0803Class isString:[dic objectForKey:@"C_ExpectPrice"]];
    }
    
    return self;
}


@end
