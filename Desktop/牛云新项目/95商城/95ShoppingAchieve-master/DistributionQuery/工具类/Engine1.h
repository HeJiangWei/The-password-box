//
//  Engine1.h
//  DistributionQuery
//
//  Created by Macx on 16/12/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);
@interface Engine1 : NSObject

//**********************************首页**********************//

#pragma mark --获取首页轮播图
+(void)huoQuFirstLunBoTusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --获取设备和物资专区
+(void)huoQuSheBeiWuZiZhuanQuClassIDType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --根据行业获取经纪人列表
+(void)huoQuJingJiRenWithHangYeID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --1.会员注册
+(void)zhuCeAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --2.会员登录
+(void)loginAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --3.获取验证码
+(void)getCodePhone:(NSString*)phone typeStr:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --4修改密码
+(void)xiuGaiMiMaPhone:(NSString*)phone Code:(NSString*)code Password:(NSString*)pwd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --5.获取首页特价专区
+(void)FirstTeJiaZhuanQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --32（gq）特价专区列表
+(void)tejiaZhuanQuLieBiaoHangYeID:(NSString*)category DiQu:(NSString*)area GuanJianZi:(NSString*)keyword Page:(NSString*)page PageSize:(NSString*)pagesize GongQiu:(NSString*)gq TeJia:(NSString*)tejia success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --33列表详情界面
+(void)tableViewXiangQingJieMianMessageID:(NSString*)messageId success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --6获取顶级产品分类
+(void)getHangYeChanPinFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --7根据行业获取分类
+(void)getHangYeWithID:(NSString*)Idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --9获取省级地区
+(void)getShengJiDiQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --10.根据省获取市
+(void)getCityWithShengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --12修改个人资料
+(void)XiuGaiMenZiLiaoNiCheng:(NSString*)nicheng Name:(NSString*)name Sheng:(NSString*)sheng City:(NSString*)city Xian:(NSString*)xian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --13修改公司资料
+(void)XiuGaiCompanyZiLiaoName:(NSString*)gongsi Address:(NSString*)adress HangYeID:(NSString*)hangyeID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --14上传图片来获取图片地址
+(void)ShangChuanImageData:(NSData*)dataImage Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --15保存图片
+(void)saveImageType:(NSString*)type urlStr:(NSString*)url success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --17获取图片
+(void)huoQuImageWithType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --19添加信息记录(浏览，收藏，关注)
+(void)addMessageJiLuMessageID:(NSString*)pid Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --20删除信息记录
+(void)deleteMessageID:(NSString*)pid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --21获取信息记录列表（浏览，收藏，关注）
+(void)getMessageJiLuType:(NSString*)type Page:(NSString*)page PageSize:(NSString*)tiaoShu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --22查询是否收藏过
+(void)isShouCangGuoMaMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --23发布产品信息
+(void)publicChanPinMessageXiangQingTitle:(NSString*)title ProductName:(NSString*)chanPiName Count:(NSString*)shuliang Type:(NSString*)type ExpectPrice:(NSString*)jiage ProductLocation:(NSString*)chandi Degree:(NSString*)chengXin Description:(NSString*)miaoshu JingJiPeope:(NSString*)jingjiID Image1:(NSString*)image1 Image2:(NSString*)image2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark--24修改产品信息
+(void)xiuGaiChanPinMessageXiangQingTitle:(NSString*)title ProductName:(NSString*)chanPiName Count:(NSString*)shuliang Type:(NSString*)type ExpectPrice:(NSString*)jiage ProductLocation:(NSString*)chandi Degree:(NSString*)chengXin Description:(NSString*)miaoshu JingJiPeope:(NSString*)jingjiID Image1:(NSString*)image1 Image2:(NSString*)image2 MessageID:(NSString*)idd  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark --25管理界面列表
+(void)guanLiLieBiaoYeShu:(NSString*)page Stype:(NSString*)stype success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --26获取资讯列表 Cid 1.行业资讯 2.公告
+(void)huoQuZiXunListViewCid:(NSString*)cid YeShuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark --28留言(意见反馈)
+(void)YiJianSuccessFanKuiOrgin:(NSString*)question1 suggest:(NSString*)jianYi PhoneNumber:(NSString*)phone success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --29优质商户
+(void)GetYouZhiShangHuPage:(NSString*)page HangYeID:(NSString*)hangye CityCode:(NSString*)citycode  GuanJianZi:(NSString*)guanjian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --36获取店铺产品列表
+(void)dianPuChanPinMessageID:(NSString*)idd Cid:(NSString*)cid Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --35 获取店铺首页
+(void)huoQuDianPuFirstMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --37 店铺产品详情
+(void)ChanPinDianPuXiangQingDianPuID:(NSString*)dianID ChanPinID:(NSString*)chanID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --39获取支付订单号
+(void)GetZhiFuDingDanHaoMoney:(NSString*)price Stype:(NSString*)stype success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --41更新产品状态
+(void)gengXinChanPinStypeMessageID:(NSString*)idd State:(NSString*)state success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --42我的服务短信发送记录
+(void)wodeFuWuMessageJiLuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --43我的服务电话记录
+(void)wodeDianHuaFuWuPage:(NSString*)page Nsdata:(NSString*)data success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --4获取版本信息
+(void)getBanBenMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//***********************第二套接口*****************************//

#pragma mark --4根据经纪人ID获取经纪人详细信息
+(void)genJuJingJiRenID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --5企业快速发布
+(void)qiYeKuaiSuPublicTitleStr:(NSString*)title Count:(NSString*)number PriceStr:(NSString*)price PhoneNumber:(NSString*)phone HangYeID:(NSString*)cid DiQuCode:(NSString*)diquID imageUrlStr:(NSString*)urlStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --6语音发布
+(void)yuyinPublicSting:(NSString*)str success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --7获取最新采购列表
+(void)huoQuCaiGouListViewPage:(NSString*)page Cid:(NSString*)cid DiQuCode:(NSString*)areid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --8获取最新采购详情
+(void)zuiXinCaiGouXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --9获取充值界面的价格和短信条数
+(void)priceGetType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
@end
