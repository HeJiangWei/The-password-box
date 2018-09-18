//
//  HomeModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
#pragma mark --特价专区Model
-(id)initWithTeJiaDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        _priceName=[Tooljw0803Class isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[Tooljw0803Class isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]];
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
        _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[Tooljw0803Class isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];//"C_User_Id
        _dianpuID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_User_Id"]]];
    }
    
    return self;
}
//优质现货
-(id)initWithYouZhiXianHuoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         NSString * image =[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        _priceName=[Tooljw0803Class isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[Tooljw0803Class isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]];
//        NSLog(@"aa输出%@",sheng);
//        NSLog(@"bb输出%@",city);
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
         // NSLog(@"cc输出%@",_cityName);
        _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[Tooljw0803Class isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
        _dianpuID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_User_Id"]]];
        if ([[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Agent"]]] isEqualToString:@"0"]) {
            _isTuo=NO;
        }else{
            _isTuo=YES;
        }
    }
    
    return self;
}

//优质商户
-(id)initWithYouZhiShangHuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_PlaceImg"]]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"M_CompanyName"]];
        NSString *city=[Tooljw0803Class isString:[dic objectForKey:@"M_CityName"]];
        NSString *sheng=[Tooljw0803Class isString:[dic objectForKey:@"M_ProvinceName"]];
       
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
      //代替收藏
        _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Hits"]]];
      //代替成交
        _sheBeiName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Volumes"]]];
        //头像
        _priceName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_HeadImg"]]];
        //电话
        _phoneNumber=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_MobieNum"]]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Id"]]];
        if ([[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Agent"]]] isEqualToString:@"0"]) {
            _isTuo=NO;
        }else{
            _isTuo=YES;
        }
    }
    
    return self;
}








//最新采购(收藏采购)
-(id)initWithCaiGouDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[Tooljw0803Class isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        _priceName=[Tooljw0803Class isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[Tooljw0803Class isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[Tooljw0803Class isString:[dic objectForKey:@"C_Prov_Name"]];
      
        _phoneNumber=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"E_Number"]]];
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
      
        _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _sheBeiName=[Tooljw0803Class isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"V_Id"]]];
        
        

    }
    
    return self;
}
////最新采购
-(id)initWithZuiXinCaiGouDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _titleName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Content"]]];
        NSString *city=[Tooljw0803Class isString:[dic objectForKey:@"CName"]];
        NSString *sheng=[Tooljw0803Class isString:[dic objectForKey:@"PName"]];
         _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
         _taishuName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
         _priceName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Price"]]];
        NSString * image =[Tooljw0803Class isString:[dic objectForKey:@"C_Pics"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
       
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
        if ([[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_AreaId"]]] isEqualToString:@"0"]) {
            _isTuo=NO;
        }else{
            _isTuo=YES;
        }
    }
    
    return self;
}
@end
