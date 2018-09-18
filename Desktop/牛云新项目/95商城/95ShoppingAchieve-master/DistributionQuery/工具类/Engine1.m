//
//  Engine1.m
//  DistributionQuery
//
//  Created by Macx on 16/12/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Engine1.h"
#import "AFNetworking.h"
@implementation Engine1
#pragma mark --获取首页轮播图
+(void)huoQuFirstLunBoTusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@index/GetRotationPic",SER_VICE];
    NSLog(@"获取首页轮播图%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取首页轮播图%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取首页轮播图%@",error);
    }];
    
}

#pragma mark --获取设备和物资专区
+(void)huoQuSheBeiWuZiZhuanQuClassIDType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@index/GetIndustry?classid=%@",SER_VICE,type];
    NSLog(@"获取设备和物资专区%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取设备和物资专区%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取设备和物资专区%@",error);
    }];
    
    
}
#pragma mark --根据行业获取经纪人列表
+(void)huoQuJingJiRenWithHangYeID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Broker/GetUserList?category=%@",SER_VICE,idd];
    NSLog(@"根据行业获取经纪人列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据行业获取经纪人列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"根据行业获取经纪人列表%@",error);
    }];
    
}
#pragma mark --1.会员注册
+(void)zhuCeAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/Register?Mobile=%@&Password=%@&Code=%@",SER_VICE,str,pwd,code];
    NSLog(@"会员注册%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.会员注册%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"会员注册"];
        NSLog(@"会员注册%@",error);
    }];
    
    
    
}
#pragma mark --2.会员登录
+(void)loginAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Login/Login?Mobile=%@&Password=%@&Code=%@",SER_VICE,str,pwd,code];
    NSLog(@"2.会员登录%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2.会员登录%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"2.会员登录%@",error);
    }];
    
}

#pragma mark --3.获取验证码
//1.注册 2.登陆 3.找回密码
+(void)getCodePhone:(NSString*)phone typeStr:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Login/GetCode?Mobile=%@&Type=%@",SER_VICE,phone,type];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSLog(@"获取验证码%@",urlStr);
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取验证码%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"获取验证码"];
        NSLog(@"获取验证码%@",error);
    }];
    
    
}

#pragma mark --4修改密码
+(void)xiuGaiMiMaPhone:(NSString*)phone Code:(NSString*)code Password:(NSString*)pwd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Login/ChangePwd?Mobile=%@&Code=%@&Password=%@",SER_VICE,phone,code,pwd];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSLog(@"4修改密码%@",urlStr);
    //    NSMutableDictionary * dic =[NSMutableDictionary new ];
    //     [dic setObject:phone forKey:@"Mobile"];
    //     [dic setObject:code forKey:@"Code"];
    //     [dic setObject:pwd forKey:@"Password"];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"4修改密码%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"获取验证码"];
        NSLog(@"4修改密码%@",error);
    }];
    
    
}

#pragma mark --5.获取首页特价专区
+(void)FirstTeJiaZhuanQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDiscountList?Count=10",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.获取首页特价专区%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"1.获取首页特价专区%@",error);
    }];
    
}





#pragma mark --32特价专区列表
+(void)tejiaZhuanQuLieBiaoHangYeID:(NSString*)category DiQu:(NSString*)area GuanJianZi:(NSString*)keyword Page:(NSString*)page PageSize:(NSString*)pagesize GongQiu:(NSString*)gq TeJia:(NSString*)tejia  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSString stringWithFormat:@"%@Commodity/GetList?Category=%@&Area=%@&Keyword=%@&Page=%@&PageSize=%@&Discount=%@&Agent=%@",SER_VICE,category,area,keyword,page,pagesize,tejia,gq];
    //搜索如果出现汉字了，需要转换编码
    NSString *urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"32特价专区列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"32特价专区列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"32特价专区列表%@",error);
    }];
}
#pragma mark --33列表详情界面
+(void)tableViewXiangQingJieMianMessageID:(NSString*)messageId success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    // http://api.hs95.com/Commodity/GetDetail?Id=7458
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDetail?Id=%@",SER_VICE,messageId];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2.列表详情界面%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"列表详情界面%@",error);
    }];
    
}
#pragma mark --6获取顶级产品分类
+(void)getHangYeChanPinFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Category/GetTopList",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"6获取顶级产品分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"6获取顶级产品分类%@",error);
    }];
    
    
    
    
}
#pragma mark --7根据行业获取分类
+(void)getHangYeWithID:(NSString*)Idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Category/GetTopList?Id=%@",SER_VICE,Idd];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据行业获取分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"根据行业获取分类%@",error);
    }];
    
}
#pragma mark --9获取省级地区
+(void)getShengJiDiQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Area/GetProvinceList",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取省级地区%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"获取省级地区%@",error);
    }];
    
}
#pragma mark --10.根据省获取市
+(void)getCityWithShengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Area/GetCityList?Id=%@",SER_VICE,code];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据省获取市%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"根据省获取市%@",error);
    }];
    
}
#pragma mark --12修改个人资料
+(void)XiuGaiMenZiLiaoNiCheng:(NSString*)nicheng Name:(NSString*)name Sheng:(NSString*)sheng City:(NSString*)city Xian:(NSString*)xian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/ModifyPersonal",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"12您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:nicheng forKey:@"NickName"];
    [dic setObject:name forKey:@"RealName"];
    if (sheng) {
        [dic setObject:sheng forKey:@"Province"];
    }if (city) {
        [dic setObject:city forKey:@"City"];
    }
    
    
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改个人资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"修改个人资料%@",error);
    }];
    
    
}
#pragma mark --13修改公司资料
+(void)XiuGaiCompanyZiLiaoName:(NSString*)gongsi Address:(NSString*)adress HangYeID:(NSString*)hangyeID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/ModifyCompany",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"13您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:gongsi forKey:@"Company"];
    if (hangyeID) {
        [dic setObject:hangyeID forKey:@"Category"];
    }if (adress) {
        [dic setObject:adress forKey:@"Address"];
    }
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改公司资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"修改公司资料%@",error);
    }];
    
    
    
}
#pragma mark --14上传图片来获取图片地址
+(void)ShangChuanImageData:(NSData*)dataImage Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@uploadfile/UpLoadProcess",SER_VICE];
    
    //获得的data
    NSData *imageData=dataImage;
    //base编码后
    NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"14您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:endStr forKey:@"img"];
    [dic setObject:type forKey:@"type"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"上传图片后返回的地址%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传图片后返回的地址%@",error);
    }];
    
}
#pragma mark --15保存图片
+(void)saveImageType:(NSString*)type urlStr:(NSString*)url success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/SaveImg",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"15您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:url forKey:@"Url"];
    NSLog(@"token=%@",[NSUSE_DEFO objectForKey:@"token"]);
    NSLog(@"UId=%@",[NSUSE_DEFO objectForKey:@"mid"]);
    NSLog(@"Type=%@",type);
    NSLog(@"Url=%@",url);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"15保存图片%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"15保存图片%@",error);
    }];
}
#pragma mark --17获取图片
+(void)huoQuImageWithType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/GetImg",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"17您还没有登录，请先登录！"];
        return;
    }
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
    //    NSLog(@"token=%@",[NSUSE_DEFO objectForKey:@"token"]);
    //    NSLog(@"UId=%@",[NSUSE_DEFO objectForKey:@"mid"]);
    //    NSLog(@"Type=%@",type);
    //    NSLog(@"Url=%@",url);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"17获取图片%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"17获取图片%@",error);
    }];
}
#pragma mark --19添加信息记录(浏览，收藏，关注)
+(void)addMessageJiLuMessageID:(NSString*)pid Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/AddViewLog",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"19您还没有登录，请先登录！"];
        return;
    }
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:pid forKey:@"PId"];
    [dic setObject:type forKey:@"Type"];
    NSLog(@"1输出看看%@",[NSUSE_DEFO objectForKey:@"token"]);
    NSLog(@"2输出看看%@",pid);
    NSLog(@"3输出看看%@",type);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"添加信息记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"添加信息记录错误%@",error);
    }];
    
}
#pragma mark --20删除信息记录
+(void)deleteMessageID:(NSString*)pid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/DeleteViewLog",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"20您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:pid forKey:@"PId"];
    NSLog(@"1输出看看%@",[NSUSE_DEFO objectForKey:@"token"]);
    NSLog(@"2输出看看%@",pid);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除信息记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"删除信息记录错误%@",error);
    }];
}
#pragma mark --21获取信息记录列表（浏览，收藏，关注）
+(void)getMessageJiLuType:(NSString*)type Page:(NSString*)page PageSize:(NSString*)tiaoShu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/GetViewLogList",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"21您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:page forKey:@"Page"];
    [dic setObject:tiaoShu forKey:@"PageSize"];
    
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取信息记录列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取信息记录列表错误%@",error);
    }];
}

#pragma mark --22查询是否收藏过
+(void)isShouCangGuoMaMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/GetViewLogDetail",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"22您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:idd forKey:@"MId"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"22查询是否收藏过%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"22查询是否收藏过%@",error);
    }];
    
}


#pragma mark --23发布产品信息
+(void)publicChanPinMessageXiangQingTitle:(NSString*)title ProductName:(NSString*)chanPiName Count:(NSString*)shuliang Type:(NSString*)type ExpectPrice:(NSString*)jiage ProductLocation:(NSString*)chandi Degree:(NSString*)chengXin Description:(NSString*)miaoshu JingJiPeope:(NSString*)jingjiID Image1:(NSString*)image1 Image2:(NSString*)image2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/AddCommodity",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"23请登录"];
    }else{
        [dic setObject:token forKey:@"Token"];
    }
    
    [dic setObject:title forKey:@"Title"];
    [dic setObject:chanPiName forKey:@"ProductName"];
    [dic setObject:shuliang forKey:@"Count"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:jiage forKey:@"ExpectPrice"];
    [dic setObject:chandi forKey:@"ProductLocation"];
    [dic setObject:chengXin forKey:@"Degree"];
    [dic setObject:miaoshu forKey:@"Description"];
    
    [dic setObject:image1 forKey:@"Img_MPhtml"];
    [dic setObject:image2 forKey:@"Img_WholePicHtml"];
    [dic setObject:jingjiID forKey:@"Agent"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取信息记录列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取信息记录列表错误%@",error);
    }];
    
}
#pragma mark--24修改产品信息
+(void)xiuGaiChanPinMessageXiangQingTitle:(NSString*)title ProductName:(NSString*)chanPiName Count:(NSString*)shuliang Type:(NSString*)type ExpectPrice:(NSString*)jiage ProductLocation:(NSString*)chandi Degree:(NSString*)chengXin Description:(NSString*)miaoshu JingJiPeope:(NSString*)jingjiID Image1:(NSString*)image1 Image2:(NSString*)image2 MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/ModifyCommodity",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"24修改产品信息"];
    }else{
        [dic setObject:token forKey:@"Token"];
    }
    
    [dic setObject:title forKey:@"Title"];
    [dic setObject:chanPiName forKey:@"ProductName"];
    [dic setObject:shuliang forKey:@"Count"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:jiage forKey:@"ExpectPrice"];
    [dic setObject:chandi forKey:@"ProductLocation"];
    [dic setObject:chengXin forKey:@"Degree"];
    [dic setObject:miaoshu forKey:@"Description"];
    [dic setObject:image1 forKey:@"Img_MPhtml"];
    [dic setObject:image2 forKey:@"Img_WholePicHtml"];
    [dic setObject:jingjiID forKey:@"Agent"];
    [dic setObject:idd forKey:@"Id"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"24修改产品信息%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"24修改产品信息%@",error);
    }];
    
}

#pragma mark --25管理界面列表
+(void)guanLiLieBiaoYeShu:(NSString*)page Stype:(NSString*)stype success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    if (token==nil) {
        [LCProgressHUD showMessage:@"25管理界面列表"];
        return;
    }
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/MyCommodity?PageSize=10&Token=%@&Agent=%@&Page=%@",SER_VICE,token,stype,page];
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取信息记录列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取信息记录列表错误%@",error);
    }];
    
    
}






#pragma mark --26获取资讯列表
+(void)huoQuZiXunListViewCid:(NSString*)cid YeShuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@News/GetNewsList?Page=%@&PageSize=10&Cid=%@",SER_VICE,page,cid];
    NSLog(@"26获取资讯列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"26获取资讯列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"26获取资讯列表%@",error);
        [LCProgressHUD hide];
    }];
    
    
}
#pragma mark --28留言(意见反馈)
+(void)YiJianSuccessFanKuiOrgin:(NSString*)question1 suggest:(NSString*)jianYi PhoneNumber:(NSString*)phone success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Message/AddMessage",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"28您还没有登录，请先登录！"];
        return;
    }
    
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:question1 forKey:@"Orgin"];
    [dic setObject:jianYi forKey:@"Other"];
    [dic setObject:phone forKey:@"Phone"];
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"留言(意见反馈)%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"留言(意见反馈)%@",error);
    }];
    
}
#pragma mark --29优质商户
+(void)GetYouZhiShangHuPage:(NSString*)page HangYeID:(NSString*)hangye CityCode:(NSString*)citycode GuanJianZi:(NSString*)guanjian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * Str =[NSString stringWithFormat:@"%@Member/GetMemberList?Page=%@&PageSize=10&Category=%@&Area=%@Keyword=%@",SER_VICE,page,hangye,citycode,guanjian];
    
    NSString *urlStr = [Str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"29优质商户%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"29优质商户%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"29优质商户%@",error);
    }];
    
}
#pragma mark --34获取店铺产品列表
+(void)dianPuChanPinMessageID:(NSString*)idd Cid:(NSString*)cid Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetShopList?ShopId=%@&Cid=%@&Page=%@&PageSize=10",SER_VICE,idd,cid,page];
    NSLog(@"34获取店铺产品列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"36获取店铺产品列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"36获取店铺产品列表%@",error);
    }];
    
    
    
}
#pragma mark --35 获取店铺首页
+(void)huoQuDianPuFirstMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Shop/GetIndex?ShopId=%@",SER_VICE,idd];
    NSLog(@"35 获取店铺首页%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"35 获取店铺首页%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"35 获取店铺首页%@",error);
    }];
    
}

#pragma mark --37 店铺产品详情
+(void)ChanPinDianPuXiangQingDianPuID:(NSString*)dianID ChanPinID:(NSString*)chanID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Shop/GetDetail?ShopId=%@&Id=%@",SER_VICE,dianID,chanID];
    NSLog(@"37 店铺产品详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"37 店铺产品详情%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"37 店铺产品详情%@",error);
        [LCProgressHUD hide];
    }];
    
    
}


#pragma mark --39获取支付订单号
+(void)GetZhiFuDingDanHaoMoney:(NSString*)price Stype:(NSString*)stype success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"39获取支付订单号"];
        return;
    }
    
    NSString * urlStrr =[NSString stringWithFormat:@"%@Alipay/GetOrder",SER_VICE];//Consult/InsertConsult
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:str forKey:@"Token"];
    [dic setObject:price forKey:@"Money"];
    [dic setObject:stype forKey:@"ChargeType"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStrr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"39获取支付订单号%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"39获取支付订单号%@",error);
        [LCProgressHUD hide];
    }];
    
    
}


#pragma mark --41更新产品状态//1.刷新 2.下架 3.置顶 4.成交
+(void)gengXinChanPinStypeMessageID:(NSString*)idd State:(NSString*)state success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"41更新产品状态"];
        return;
    }
    
    NSString * urlStrr =[NSString stringWithFormat:@"%@Commodity/ChangeCommodity",SER_VICE];//Consult/InsertConsult
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:str forKey:@"Token"];
    [dic setObject:idd forKey:@"Id"];
    [dic setObject:state forKey:@"State"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStrr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"41更新产品状态%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"41更新产品状态%@",error);
        [LCProgressHUD hide];
    }];
    
    
}
#pragma mark --42我的服务短信发送记录
+(void)wodeFuWuMessageJiLuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"42我的服务短信发送记录"];
        return;
    }
    NSString * urlStr =[NSString stringWithFormat:@"%@MyService/MessageList?Page=%@&PageSize=10&Token=%@",SER_VICE,page,str];
    NSLog(@"42我的服务短信发送记录%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"42我的服务短信发送记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"42我的服务短信发送记录%@",error);
        [LCProgressHUD hide];
        
    }];
    
}
#pragma mark --43我的服务电话记录
+(void)wodeDianHuaFuWuPage:(NSString*)page Nsdata:(NSString*)data success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"43我的服务电话记录"];
        return;
    }
    NSString * urlStr =[NSString stringWithFormat:@"%@MyService/MessageList?Page=%@&PageSize=10&Token=%@",SER_VICE,page,str];
    NSLog(@"43我的服务电话记录%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"43我的服务电话记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"43我的服务电话记录%@",error);
        [LCProgressHUD hide];
        
    }];
    
}

#pragma mark --44获取版本信息
+(void)getBanBenMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Message/GetAbout",SER_VICE];
    NSLog(@"44获取版本信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"44获取版本信息%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"44获取版本信息%@",error);
        [LCProgressHUD hide];
        
    }];
    
    
}


//***********************第二套接口*****************************//

#pragma mark --4根据经纪人ID获取经纪人详细信息
+(void)genJuJingJiRenID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Broker/GetUserById?Userid=%@",SER_VICE,idd];
    NSLog(@"4根据经纪人ID获取经纪人详细信息%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"4根据经纪人ID获取经纪人详细信息%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"4根据经纪人ID获取经纪人详细信息%@",error);
        [LCProgressHUD hide];
        
    }];
    
    
    
}





#pragma mark --5企业快速发布
+(void)qiYeKuaiSuPublicTitleStr:(NSString*)title Count:(NSString*)number PriceStr:(NSString*)price PhoneNumber:(NSString*)phone HangYeID:(NSString*)cid DiQuCode:(NSString*)diquID imageUrlStr:(NSString*)urlStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStrr =[NSString stringWithFormat:@"%@Consult/InsertConsult",SER_VICE];//Consult/InsertConsult
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:title forKey:@"Title"];
    [dic setObject:number forKey:@"Count"];
    [dic setObject:price forKey:@"Price"];
    [dic setObject:phone forKey:@"PhoneNum"];
    [dic setObject:cid forKey:@"Cid"];
    [dic setObject:diquID forKey:@"Cityid"];
    [dic setObject:urlStr forKey:@"Images"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStrr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"5企业快速发布%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"5企业快速发布%@",error);
        [LCProgressHUD hide];
    }];
    
    
}
#pragma mark --6语音发布
+(void)yuyinPublicSting:(NSString*)str success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStrr =[NSString stringWithFormat:@"%@Consult/InsertVoice",SER_VICE];//Consult/InsertConsult
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:str forKeyedSubscript:@"Content"];
    [dic setObject:@"1" forKeyedSubscript:@"TypeId"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStrr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"6语音发布%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"6语音发布%@",error);
        [LCProgressHUD hide];
    }];
}
#pragma mark --7获取最新采购列表
+(void)huoQuCaiGouListViewPage:(NSString*)page Cid:(NSString*)cid DiQuCode:(NSString*)areid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"7您还没有登录，请先登录！"];
        return;
    }
    
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    NSString * urlStr =[NSString stringWithFormat:@"%@Consult/GetConsultList?token=%@&cid=%@&Page=%@&pageSize=10&Areaid=%@",SER_VICE,token,cid,page,areid];
    NSLog(@"7获取最新采购列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"7获取最新采购列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"7获取最新采购列表%@",error);
    }];
    
}
#pragma mark --8获取最新采购详情
+(void)zuiXinCaiGouXiangQingMessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * str =[NSUSE_DEFO objectForKey:@"token"];
    if (str==nil) {
        [LCProgressHUD showMessage:@"8您还没有登录，请先登录！"];
        return;
    }
    
    NSString * token =[NSUSE_DEFO objectForKey:@"token"];
    NSString * urlStr =[NSString stringWithFormat:@"%@Consult/GetConsultList?token=%@&consultId=%@",SER_VICE,token,idd];
    NSLog(@"8获取最新采购详情%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"8获取最新采购详情%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"8获取最新采购详情%@",error);
        [LCProgressHUD hide];
        
    }];
    
}
#pragma mark --9获取充值界面的价格和短信条数
+(void)priceGetType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Alipay/GetPDRecharge?type=%@",SER_VICE,type];
    NSLog(@"9获取充值界面的价格和短信条数%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"9获取充值界面的价格和短信条数%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"9获取充值界面的价格和短信条数%@",error);
        [LCProgressHUD hide];
        
    }];
    
}
@end
