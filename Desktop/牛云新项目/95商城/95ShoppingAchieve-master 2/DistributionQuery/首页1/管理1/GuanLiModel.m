//
//  GuanLiModel.m
//  DistributionQuery
//
//  Created by Macx on 16/12/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GuanLiModel.h"

@implementation GuanLiModel
-(id)initWithGuanLiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _titleName=[Tooljw0803Class isString:[dic objectForKey:@"C_Title"]];
        //昵称
          _nikeName=[Tooljw0803Class isString:[dic objectForKey:@"C_ProductName"]];
        //数量
          _numName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        //型号
          _xingHaoName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Type"]]];
        //产地
          _addressName=[Tooljw0803Class isString:[dic objectForKey:@"C_ProductLocation"]];
        //成色
          _chengseName=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@成新",[dic objectForKey:@"C_Degree"]]];
        //成色code
         _chengseCode=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Degree"]]];
        
        
        //详细
          _xiangXiName=[Tooljw0803Class isString:[dic objectForKey:@"C_Description"]];
        
        //整机图片
        _imageurl=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_Img_WholePicHtml"]]];
        //铭牌图片
        _imageurl2=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[Tooljw0803Class isString:[dic objectForKey:@"C_Img_MPhtml"]]];
        //经纪人ID
        _jingjiID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Agent"]]];
        //价格
        _priceName=[Tooljw0803Class isString:[dic objectForKey:@"C_ExpectPrice"]];
        _chaKan=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _messageID=[Tooljw0803Class isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
    }
    
    return self;
}
@end
