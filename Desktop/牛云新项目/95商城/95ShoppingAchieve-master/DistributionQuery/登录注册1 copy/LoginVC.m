//
//  LoginVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
#import "ForGetPwdVC.h"
@interface LoginVC ()
@property(nonatomic,strong)UIImageView * topImageview;//天空图片
@property(nonatomic,strong)UITextField *phoneText;//手机号
@property(nonatomic,strong)UITextField *pwdText;//请输入密码
@property(nonatomic,strong)UITextField * codeText;//输入验证码
@property(nonatomic,strong)UIButton * codeBtn;//获取验证码
@property(nonatomic,strong)UIButton * forgetBtn;//忘记密码
@property(nonatomic,strong)UIButton * loginBtn;
@property(nonatomic,strong)UIView * lineView1;
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)UIView * lineView3;
@property(nonatomic,strong)UIView * bgview;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"95商城";
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatRightBtn];
    [self CreatTopImageView];//创建天空的图片
    [self CreatView];
    [self CreatLoginBtn];//登录按钮
}

#pragma mark --注册
-(void)CreatRightBtn{
    //搜索按钮
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"注册" forState:0];
    [rightBtn setTitleColor:[UIColor redColor] forState:0];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:TITLE_FOUNT];
    rightBtn.frame=CGRectMake(0, 0, 50, 15);
    [rightBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtnn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtnn];

}



#pragma mark--  创建天空的图片
-(void)CreatTopImageView{
    _topImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_banner"]];
    [self.view sd_addSubviews:@[_topImageview]];
    _topImageview.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .rightSpaceToView(self.view,0)
    .heightIs(ScreenWidth*434/750);
}
#pragma mark --创建白色的view
-(void)CreatView{
    _bgview=[[UIView alloc]init];
    _bgview.backgroundColor=[UIColor whiteColor];
    _bgview.userInteractionEnabled=YES;
    [self.view sd_addSubviews:@[_bgview]];
    _bgview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_topImageview,20);
    
    //手机号
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"手机号";
     _phoneText.keyboardType=UIKeyboardTypePhonePad;
    _phoneText.alpha=1;
    _phoneText.leftView =[self imageViewNameStr:@"phone"];
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_phoneText]];
    _phoneText.sd_layout
    .leftSpaceToView(_bgview,40)
    .rightSpaceToView(_bgview,40)
    .heightIs(30)
    .topSpaceToView(_bgview,10);
    
    //线条1
    _lineView1=[UIView new];
    _lineView1.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView1]];
    _lineView1.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .topSpaceToView(_phoneText,10)
    .heightIs(1);
    
    //请输入密码
    _pwdText=[[UITextField alloc]init];
    _pwdText.placeholder=@"请输入密码";
    _pwdText.alpha=1;
     _pwdText.keyboardType=UIKeyboardTypePhonePad;
    _pwdText.leftView =[self imageViewNameStr:@"login_ps"];
    _pwdText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_pwdText]];
    _pwdText.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView1,15);
    
    //线条2
    _lineView2=[UIView new];
    _lineView2.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView2]];
    _lineView2.sd_layout
    .leftEqualToView(_lineView1)
    .rightEqualToView(_lineView1)
    .topSpaceToView(_pwdText,10)
    .heightIs(1);
    
    //获取验证码btn
    _codeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.backgroundColor=COLOR;
    [_codeBtn setTitle:@"获取验证码" forState:0];
   
    [_codeBtn setTitleColor:[UIColor blackColor] forState:0];
    _codeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
     [_codeBtn addTarget:self action:@selector(yanzhengCode:) forControlEvents:UIControlEventTouchUpInside];
    [_bgview sd_addSubviews:@[_codeBtn]];
    _codeBtn.sd_layout
    .widthIs(100)
    .rightEqualToView(_phoneText)
    .heightIs(40)
    .topSpaceToView(_lineView2,10);
    
    
    //请输入验证码
    _codeText=[[UITextField alloc]init];
    _codeText.placeholder=@"请输入验证码";
     _codeText.keyboardType=UIKeyboardTypePhonePad;
    _codeText.leftView =[self imageViewNameStr:@"login_yanzhnegma"];
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_codeText]];
    _codeText.sd_layout
    .leftEqualToView(_phoneText)
    .rightSpaceToView(_codeBtn,0)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView2,15);
    
    //线条3
    _lineView3=[UIView new];
    _lineView3.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView3]];
    _lineView3.sd_layout
    .leftEqualToView(_lineView2)
    .rightEqualToView(_lineView2)
    .topSpaceToView(_codeText,10)
    .heightIs(1);

    //忘记密码
    _forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_forgetBtn setTitle:@"忘记密码?" forState:0];
    [_forgetBtn setTitleColor:[UIColor redColor] forState:0];
    _forgetBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _forgetBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [_forgetBtn addTarget:self action:@selector(wangjiPwd) forControlEvents:UIControlEventTouchUpInside];
    [_bgview sd_addSubviews:@[_forgetBtn]];
    _forgetBtn.sd_layout
    .widthIs(100)
    .rightEqualToView(_lineView3)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView3,10);
    
    [_bgview setupAutoHeightWithBottomView:_forgetBtn bottomMargin:10];
    
    
    
}
#pragma mark --忘记密码
-(void)wangjiPwd{
    ForGetPwdVC * vc =[ForGetPwdVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --获取验证码
-(void)yanzhengCode:(UIButton*)sender{
    NSLog(@"手机号%@",_phoneText.text);
    [LCProgressHUD showLoading:@"正在获取验证码..."];
    [Engine1 getCodePhone:_phoneText.text typeStr:@"2" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            //实现倒计时
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                    });
                }
                else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --登录按钮
-(void)CreatLoginBtn{
    //登录
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor=[UIColor redColor];
   // [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_bt"] forState:0];
    [_loginBtn setTitle:@"登录" forState:0];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    _loginBtn.sd_cornerRadius=@(5);
    [_loginBtn addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[_loginBtn]];
    _loginBtn.sd_layout
    .leftEqualToView(_lineView3)
    .rightEqualToView(_lineView3)
    .heightIs(40)
    .topSpaceToView(_bgview,0);

}


#pragma mark --点击登录按钮
-(void)loginButton:(UIButton*)btn{
    [Engine1 loginAccountPhoneNumber:_phoneText.text Pwd:_pwdText.text CodeStr:_codeText.text success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [NSUSE_DEFO setObject:[dic objectForKey:@"Item2"] forKey:@"token"];
            NSDictionary * item3Dic =[dic objectForKey:@"Item3"];
            [NSUSE_DEFO setObject:[NSString stringWithFormat:@"%@",[item3Dic objectForKey:@"M_Id"]] forKey:@"mid"];
            [NSUSE_DEFO synchronize];
           // NSDictionary * item3 =[dic objectForKey:@"Item3"];
            [self saveSomeMessageDic:item3Dic];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
}

#pragma mark --存储登录信息
-(void)saveSomeMessageDic:(NSDictionary*)dic{
    //1.存储用户名
//    NSMutableDictionary * saveDic=[NSMutableDictionary new];
//    [saveDic setObject:[dic objectForKey:@"M_UserName"] forKey:@"M_UserName"];
//    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Id"]] forKey:@"M_Id"];
//    [ToolClass savePlist:saveDic name:@"Login"];
    //1.存储用户名
    NSMutableDictionary * saveDic=[NSMutableDictionary new];
    [saveDic setObject:[dic objectForKey:@"M_UserName"] forKey:@"M_UserName"];
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Id"]] forKey:@"M_Id"];
    //存真实名字
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_RealName"]] forKey:@"M_RealName"];
    //存昵称
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_NickName"]] forKey:@"M_NickName"];
    //省code
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Province"]] forKey:@"M_Province"];
    //市code
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_City"]] forKey:@"M_City"];
    //省name
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_ProvinceName"]] forKey:@"M_ProvinceName"];
    //市name
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_CityName"]] forKey:@"M_CityName"];
    //公司的名字
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_CompanyName"]] forKey:@"M_CompanyName"];
    //经营行业ID
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Category"]] forKey:@"M_Category"];
    //经营行业name
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_CategoryName"]] forKey:@"M_CategoryName"];
    //所在场所
    [saveDic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Address"]] forKey:@"M_Address"];
    
    [ToolClass savePlist:saveDic name:@"Login"];
    
}


#pragma mark --注册
-(void)registBtn:(UIButton*)btn{
    RegistVC * vc =[RegistVC new];
    vc.userNamePswBlock=^(NSString*user,NSString*psw){
        _phoneText.text=user;
        _pwdText.text=psw;
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIButton*)imageViewNameStr:(NSString*)imageName{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    
    btn.frame=CGRectMake(0, 0, 30, 30);
    return btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
