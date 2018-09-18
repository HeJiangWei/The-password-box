//
//  YuYinPublicVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YuYinPublicVC.h"

@interface YuYinPublicVC ()
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UITextView * textView;
@end

@implementation YuYinPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_tagg==0) {
       self.title=@"标题";
    }else{
       self.title=@"语音发布";
    }
   
    self.automaticallyAdjustsScrollViewInsets=NO;
    _bgView=[UIView new];
    _bgView.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_bgView]];
    _bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10+64)
    .bottomSpaceToView(self.view,0);
    [self CreatRightBtn];
    [self CreatTextView];
    
    
    
}

-(void)CreatRightBtn{
    UIButton * _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    //搜索按钮
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"发布" forState:0];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:TITLE_FOUNT];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    [_rightBtn setTitleColor:[UIColor redColor] forState:0];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems=@[rightBtn];
    //
}
#pragma mark --点击发布
-(void)rightClick:(UIButton*)btn{
    NSLog(@"内容>>>>%@",_textView.text);
    [Engine1 yuyinPublicSting:_textView.text success:^(NSDictionary *dic)
    {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
             [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}

-(void)CreatTextView{
    _textView=[[UITextView alloc]init];
    _textView.backgroundColor=[UIColor whiteColor];
    _textView.font=[UIFont systemFontOfSize:17];
    _textView.layer.borderWidth=1;
    _textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    [_bgView sd_addSubviews:@[_textView]];
    _textView.sd_layout
    .leftSpaceToView(_bgView,10)
    .rightSpaceToView(_bgView,10)
    .topSpaceToView(_bgView,15)
    .heightIs(250);
    
    UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"biaoti_del"] forState:0];
    [_textView sd_addSubviews:@[deleteBtn]];
    deleteBtn.sd_layout
    .rightSpaceToView(_textView,10)
    .bottomSpaceToView(_textView,10)
    .widthIs(173/2)
    .heightIs(43/2);
    
    UIButton * publicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setImage:[UIImage imageNamed:@"biaoti_yuyin"] forState:0];
    [_bgView sd_addSubviews:@[publicBtn]];
    publicBtn.sd_layout
    .centerXEqualToView(_bgView)
    .bottomSpaceToView(_bgView,20)
    .widthIs(220)
    .heightIs(50);
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_bgView endEditing:YES];
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
