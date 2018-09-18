//
//  FuWuChongZhiVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuWuChongZhiVC.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@interface FuWuChongZhiVC ()
@property(nonatomic,strong)UIButton*lastBtn;
@property(nonatomic,strong)UILabel * lastLabel;
@end

@implementation FuWuChongZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tagg==0) {
        self.title=@"短信充值";
    }else{
         self.title=@"400充值";
    }
   
    self.view.backgroundColor=[UIColor whiteColor];
    [self Creat];
}
-(void)Creat{
    //图片
    UIImageView * imageview= [[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"guyong_pic"];
    [self.view sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .topSpaceToView(self.view,10+64)
    .heightIs(360*(ScreenWidth-20)/690);
//温馨提示
    UILabel * tishiLabel =[UILabel new];
    tishiLabel.text=@"温馨提示";
    tishiLabel.font=[UIFont systemFontOfSize:14];
    tishiLabel.textColor=[UIColor redColor];
    tishiLabel.alpha=.7;
    [self.view sd_addSubviews:@[tishiLabel]];
    tishiLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(imageview,25)
    .autoHeightRatio(0);
    [tishiLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
    
    UILabel * contentLabel =[UILabel new];
    if (_tagg==0) {
         contentLabel.text=@"1.充值短信后，即可发送短信至商家手机；\n2.短信内容建议，对应货源、自己的联系方式；\n3.禁止发送违规、违法的消息内容。";
    }else{
         contentLabel.text=@"                       首次认证成功的客户，\n即可得到20分钟400被叫通话!商家联系更方便哦！";
    }
   
    contentLabel.font=[UIFont systemFontOfSize:13];
    contentLabel.textColor=[UIColor blackColor];
    contentLabel.alpha=.7;
    [self.view sd_addSubviews:@[contentLabel]];
    contentLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(tishiLabel,15)
    .autoHeightRatio(0);
    [contentLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-60];
    /*
     type=1 短信充值
     type=2 400充值
     type=3 置顶充值
     */
    [Engine1 priceGetType:[NSString stringWithFormat:@"%lu",_tagg+1] success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            
            NSArray * item2Arr =[dic objectForKey:@"Item2"];
            NSMutableArray * moneyArr =[NSMutableArray new];
             NSMutableArray * countArr =[NSMutableArray new];
            for (NSDictionary * dicc in item2Arr) {
                NSString * money =[NSString stringWithFormat:@"%@",[dicc objectForKey:@"Money"]];
                NSString * count =[NSString stringWithFormat:@"%@",[dicc objectForKey:@"Count"]];
                [moneyArr addObject:money];
                [countArr addObject:count];
            }
           
            //2个按钮
            NSArray * arr=nil;
            NSArray * sarr=nil;
            NSArray * titleArr=nil;
            int d=0;
            if (_tagg==0) {
               
                NSString * mon =[NSString stringWithFormat:@"%@元",moneyArr[0]];
                NSString * tiao =[NSString stringWithFormat:@"%@条",countArr[0]];
                NSString * str =[NSString stringWithFormat:@"%@\n\n%@",tiao,mon];
                NSString * mon1 =[NSString stringWithFormat:@"%@元",moneyArr[1]];
                NSString * tiao1 =[NSString stringWithFormat:@"%@条",countArr[1]];
                NSString * str1 =[NSString stringWithFormat:@"%@\n\n%@",tiao1,mon1];
                arr =@[@"messege_line",@"messege_line"];
                sarr =@[@"messege_line_red",@"messege_line_red"];
                titleArr =@[str,str1];//@[tiao\n\nmon",@"200条\n\n900元"];
                d =(ScreenWidth-125*arr.count)/(arr.count+1);
            }else  if (_tagg==1){
                NSString * mon =[NSString stringWithFormat:@"%@元",moneyArr[0]];
                NSString * tiao =[NSString stringWithFormat:@"%@分钟",countArr[0]];
                NSString * str =[NSString stringWithFormat:@"%@\n\n%@",tiao,mon];
                NSString * mon1 =[NSString stringWithFormat:@"%@元",moneyArr[1]];
                NSString * tiao1 =[NSString stringWithFormat:@"%@分钟",countArr[1]];
                NSString * str1 =[NSString stringWithFormat:@"%@\n\n%@",tiao1,mon1];
                
                NSString * mon2 =[NSString stringWithFormat:@"%@元",moneyArr[2]];
                NSString * tiao2 =[NSString stringWithFormat:@"%@分钟",countArr[2]];
                NSString * str2 =[NSString stringWithFormat:@"%@\n\n%@",tiao2,mon2];
                
                
                arr =@[@"messege_line",@"messege_line",@"messege_line"];
                sarr =@[@"messege_line_red",@"messege_line_red",@"messege_line_red"];
               // titleArr =@[@"1000分钟\n\n1000元",@"2000分钟\n\n1600元",@"5000分钟\n\n3000元"];
                titleArr=@[str,str1,str2];
                d =(ScreenWidth-99*arr.count)/(arr.count+1);
            }
            
            for (int i =0; i<arr.count; i++) {
                UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
                [btn setImage:[UIImage imageNamed:arr[i]] forState:0];
                [btn setImage:[UIImage imageNamed:sarr[i]] forState:UIControlStateSelected];
                btn.tag=i;
                UILabel * nameLabel =[UILabel new];
                if (i==0) {
                    btn.selected=YES;
                    _lastBtn=btn;
                    nameLabel.textColor=[UIColor redColor];
                    _lastLabel=nameLabel;
                }
                
                nameLabel.tag=1;
                nameLabel.numberOfLines=0;
                nameLabel.textAlignment=1;
                nameLabel.font=[UIFont systemFontOfSize:14];
                nameLabel.text=titleArr[i];
                [btn sd_addSubviews:@[nameLabel]];
                nameLabel.sd_layout
                .leftSpaceToView(btn,0)
                .rightSpaceToView(btn,0)
                .topSpaceToView(btn,0)
                .bottomSpaceToView(btn,0);
                
                
                [btn addTarget:self action:@selector(duanXinBtn:) forControlEvents:UIControlEventTouchUpInside];
                [self.view sd_addSubviews:@[btn]];
                if (_tagg==0) {
                    btn.sd_layout
                    .leftSpaceToView(self.view,d+(125+d)*i)
                    .topSpaceToView(contentLabel,30)
                    .widthIs(250/2)
                    .heightIs(142/2);
                }else{
                    btn.sd_layout
                    .leftSpaceToView(self.view,d+(99+d)*i)
                    .topSpaceToView(contentLabel,30)
                    .widthIs(188/2)
                    .heightIs(142/2);
                }
                
                
                
            }
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
   
    
    //立即充值按钮
    UIButton * chongZhiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chongZhiBtn setImage:[UIImage imageNamed:@"chonzghi_bt"] forState:0];
    [chongZhiBtn addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[chongZhiBtn]];
    chongZhiBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,40)
    .widthIs(450/2)
    .heightIs(77/2);
    
}
#pragma mark --短信
-(void)duanXinBtn:(UIButton*)btn{
    _lastBtn.selected=!_lastBtn.selected;
    btn.selected=!btn.selected;
    _lastBtn=btn;
    _lastLabel.textColor=[UIColor blackColor];
    UILabel * namelable=[[btn subviews] objectAtIndex:1];
    namelable.textColor=[UIColor redColor];
    _lastLabel=namelable;
}
#pragma mark --获取支付宝订单号
-(void)chongZhi{
//    [Engine GetZhiFuDingDanHaoMoney:@"500" Stype:@"4" success:^(NSDictionary *dic) {
//        
//    } error:^(NSError *error) {
//        
//    }];
    [self doAlipayPay];
}

#pragma mark --支付宝集成
-(void)doAlipayPay{
//2016120503876419
    NSString *appID = @"2088421728335148";//@"2088421728335148";
    NSString *seller = @"514622205@qq.com";
//    NSString *privateKey =@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMV0C3pcJZ2OzCWUOc9wmnGsxIPSux+7fPe4LgwcouGz0jtyCe6Mzcdj1QUwI+NZapFLjIkKLHONAjX57sT0PJWNFtQmonyLaW61z6xiCJvtn8dw768ibYoSZDUN/Vfpy/2vsg0WASGxrOuHAXdU/cJYjO2az493Bmz2sO9xWNqbAgMBAAECgYBbQBDZ4GHl2YtQxpqc2k4VwKEkxquBs7TCCpUFNeq0YdUDceVTIDEtN17HwgKj27vbH833uwLl98GQzkthK/oe1xYhVMKjkEr0FP6L1kvkjhY/0k9dBjliagA1Vj9f45YWIfh8Rwy8+HpHN+5d+zcMPtAHy5gx2ofgYIYT23P5AQJBAOog/FXS92q7oYw9+nrqgBp5fDAhqrJMFconqSf8hON0EPYH6rzGzwlsp/0A+7MXHj75fANxpwfZKpmxdP9bqYECQQDX5f251kmoGZwJfJcta0oaLWc8C2EjxqtWm+EJTZ0mKKTaeMuFLjgBODpkSDHHPDoSwsw69L847DOK7uzWJvobAkAqGRRGOlDSmDpMBTjssQ2ntQBnhyYyOQwR9V+tGPKsE0qZcoL6vqSrhSYPkAWyBg4iNKnf1Ke7+Yh3ajknUUwBAkEAuT0F83ree7JtZN5XP4r8a3VlS+lfkTiWLZtU+4xyNxlMSH638C71smYyA3TF8PHFye8FF9iCcS6IEr5oyl1q3QJBAIjv5viNjx4STAeq+MvTpkC6YQtLNt5pGfiy6XfJQR4ojtaZNSiNmQbgTcNgxrDNhZUZIRruynLzQdZkbq6rkkA=";
//
    NSString*privateKey= @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAPKkAp77qxbuOZrxKm0E0oRlhv0/4NnaqNlr9/kwb+bRs76RbrFKPADmQokDcDFAO1Vj2x5ASSKLX8KkEbuVM2QKXYEwDPjIj1b1wMCS4lIIDzCXa6aY2if4pcrSmI9YLKoe1wZuuKibd5W25dESX049IikGvalNmW3utnoSrXnPAgMBAAECgYB8BHpWejm7ca291RAjQri69Q2m+XRaxVlSL85B7pDzgDGH8NuMAG5k40wUrc41TihFf9FqR99ZqbUbTjLGFv95XsyOh8da+ZNsZVWfMIfu9jBD5r/vcPY/34t3X0qhfzw78Y6MSNN+hgCVfkjf3i3MuC8KpZ/BtAHUD1C6B9TUOQJBAPvvj4/FOYdVgegmamUwNEEE2JIAfQmlMmjdcY8u7GbaytWe4+jFXHUaQqgnnYXeoT+RWXuE5FBqbyDf5Rcqj4sCQQD2jhAKY6bSg5Mfk+2g1hvOCBLFx+zdF/zkcYAO8nA8YO0wdDLCuZwAlkPGDXXW2ecFGlx9KgZPoGTUeyzhSodNAkB1kQKGjfvdqsp3gk3OMKOB3/gMkgvHj36prwUKU1RgXyOecopampcd0oZeoDYDPbQzzOlcGdTNrg1z4ueuWt8nAkBSL6zdKba0ObPTNOZjVLvUBBDt6OTmFlbwd30uflY3aj/mhPVev6xm7bAN1vLO+bfulYj7GAUeieLSiXS+bK+JAkAYA2aagzCkhfNmWZmFAMIhadS5/+pGBZXOICaF8MIxeNrWqxqI6V4IYS5315lmALYoGByIhDkEm3I2l7APfWIP";// 私钥
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    order.biz_content.seller_id=seller;
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = @"afavva1213afafagaga"; //订单ID（由商家自行制定）
   order.notify_url=@"http://119.29.83.154:8080/OrderSystem/payment/app_alipayCallBack.action";
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式orderInfoEncoded signedString
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"开始reslut = %@",resultDic);
        }];
    }

    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
