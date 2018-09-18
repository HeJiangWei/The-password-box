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
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        //昵称
          _nikeName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
        //数量
          _numName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        //型号
          _xingHaoName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Type"]]];
        //产地
          _addressName=[ToolClass isString:[dic objectForKey:@"C_ProductLocation"]];
        //成色
          _chengseName=[ToolClass isString:[NSString stringWithFormat:@"%@成新",[dic objectForKey:@"C_Degree"]]];
        //成色code
         _chengseCode=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Degree"]]];
        
        
        //详细
          _xiangXiName=[ToolClass isString:[dic objectForKey:@"C_Description"]];
        
        //整机图片
        _imageurl=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_Img_WholePicHtml"]]];
        //铭牌图片
        _imageurl2=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[ToolClass isString:[dic objectForKey:@"C_Img_MPhtml"]]];
        //经纪人ID
        _jingjiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Agent"]]];
        //价格
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        _chaKan=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
    }
    
    return self;
}
@end
