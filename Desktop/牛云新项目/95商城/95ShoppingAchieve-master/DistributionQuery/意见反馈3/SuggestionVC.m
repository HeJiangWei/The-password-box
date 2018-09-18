//
//  SuggestionVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SuggestionVC.h"
#import "PopView.h"
@interface SuggestionVC ()
{
    UIView * view1;
    UIView * view2;
    UIView * view3;
    UIView * bgview;
    PopView * pop;
    NSString * btnName;
    UITextView * _textView;
    UITextField * _textfiled;
}
@property(nonatomic,retain)NSArray * dataArray;
@end

@implementation SuggestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"意见反馈";
    _dataArray=@[@"暂不选择",@"注册登录",@"不稳定",@"页面不美观",@"系统崩溃",@"忘记密码",@"内容不适",@"产品建议",@"发布信息相关"];
   
    bgview =self.view;
 [self view1];
}
-(void)view1{
    view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view1]];
    view1.sd_layout
    .topSpaceToView(bgview,10+64)
    .leftSpaceToView(bgview,0)
    .rightSpaceToView(bgview,0)
    .heightIs(50*ScreenHeight/667);
    
    UILabel * label =[UILabel new];
    label.text=@"反馈类型";
    label.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[label]];
    label.sd_layout
    .centerYEqualToView(view1)
    .leftSpaceToView(view1,20)
    .heightIs(30);
    [label setSingleLineAutoResizeWithMaxWidth:120];
    
    
    UIButton * chooseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setTitle:@"暂不选择" forState:0];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"选择"] forState:0];
    chooseBtn.adjustsImageWhenHighlighted=NO;
    chooseBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [chooseBtn setTitleColor:[UIColor blackColor] forState:0];
    chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [chooseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [chooseBtn addTarget:self action:@selector(successBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view1 sd_addSubviews:@[chooseBtn]];
    CGRect  aa = CGRectMake(self.view.frame.size.width/2, 15+64, self.view.frame.size.width/2-10, 30*_dataArray.count);
    pop =[[PopView alloc]initWithFrame:aa];
    pop.dataArray=_dataArray;
    pop.btnNameBlock=^(NSString*name){
        [chooseBtn setTitle:name forState:0];
        btnName=name;
    };
    chooseBtn.sd_layout
    .leftSpaceToView(label,15)
    .centerYEqualToView(view1)
    .heightIs(30)
    .rightSpaceToView(view1,20);
    
    
    
    
    
    [self view2];
}
-(void)view2{
    
    view2=[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view2]];
    view2.sd_layout
    .topSpaceToView(view1,10)
    .leftSpaceToView(bgview,0)
    .rightSpaceToView(bgview,0)
    .heightIs(200*ScreenHeight/667);
    
    UILabel * label =[UILabel new];
    label.text=@"问题/建议";
    label.font=[UIFont systemFontOfSize:15];
    
    _textView=[UITextView new];
    _textView.text=@"输入您要反馈的具体内容";
    _textView.layer.borderWidth=1;
    _textView.layer.borderColor=[COLOR CGColor];
    _textView.layer.cornerRadius=5;
    _textView.clipsToBounds=YES;
    [view2 sd_addSubviews:@[label,_textView]];
    label.sd_layout
    .topSpaceToView(view2,15)
    .leftSpaceToView(view2,20)
    .heightIs(30);
    [label setSingleLineAutoResizeWithMaxWidth:120];
    
    _textView.sd_layout
    .topSpaceToView(view2,15)
    .leftSpaceToView(label,15)
    .rightSpaceToView(view2,20)
    .bottomSpaceToView(view2,15);//换成高度自适应
    
    [self view3];
    
}

-(void)view3
{
    view3=[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view3]];
    view3.sd_layout
    .topSpaceToView(view2,10)
    .leftSpaceToView(bgview,0)
    .rightSpaceToView(bgview,0)
    .heightIs(50*ScreenHeight/667);
    
    UILabel * label =[UILabel new];
    label.text=@"联系方式";
    label.font=[UIFont systemFontOfSize:15];
    
    _textfiled=[UITextField new];
    _textfiled.placeholder=@"    手机号";
    [_textfiled setValue:[UIColor blackColor]forKeyPath:@"_placeholderLabel.textColor"];
    _textfiled.layer.borderWidth=1;
    _textfiled.layer.borderColor=[COLOR CGColor];
    _textfiled.layer.cornerRadius=5;
    _textfiled.clipsToBounds=YES;
    _textfiled.keyboardType=UIKeyboardTypeNumberPad;
    _textfiled.font=[UIFont systemFontOfSize:15];
    [view3 sd_addSubviews:@[label,_textfiled]];
    label.sd_layout
    .centerYEqualToView(view3)
    .leftSpaceToView(view3,20)
    .heightIs(30);
    [label setSingleLineAutoResizeWithMaxWidth:120];
    
    _textfiled.sd_layout
    .topEqualToView(label)
    .leftSpaceToView(label,15)
    .rightSpaceToView(view3,20)
    .heightIs(30);//换成高度自适应
    
    
    
    [self commitBtn];
    
    
    
    
    
}

-(void)commitBtn
{
    UIButton * commBtn =[UIButton new];
    [commBtn setTitle:@"提交" forState:0];
    [commBtn setBackgroundImage:[UIImage imageNamed:@"提交按钮"] forState:0];
    [commBtn addTarget:self action:@selector(tijiao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[commBtn]];
    commBtn.sd_layout
    .bottomSpaceToView(self.view,30)
    .centerXEqualToView(self.view)
    .widthIs(449/2)
    .heightIs(73/2);
    
}
//意见反馈按钮
-(void)successBtn:(UIButton*)btn{
    [pop show];
    [self.view addSubview:pop];
}


//提交按钮
-(void)tijiao:(UIButton*)btn
{
    NSLog(@"问题意见>>%@",_textView.text);
    NSLog(@"联系方式>>%@",_textfiled.text);
    NSLog(@"反馈类型>>%@",btnName);
    [Engine1 YiJianSuccessFanKuiOrgin:btnName suggest:_textView.text PhoneNumber:_textfiled.text success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
             [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    //    [Engine getLiuYanxxid:@"0" contact:btnName handtel:_textfiled.text content:_textView.text type:@"0" uid:@"0" ruid:@"0" success:^(NSDictionary *dic) {
    //        [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
    //    } error:^(NSError *error) {
    //
    //    }];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

@end
