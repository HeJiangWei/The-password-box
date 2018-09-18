//
//  ScanCodeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ScanCodeVC.h"
#import "ScanCodeCell.h"
#import "PublicTypeVC.h"
#import "CityChooseVC.h"
#import "ChengSeViewController.h"
@interface ScanCodeVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    UITextView * textViewText;//详细信息
    NSString * _mingPaiUrl;//铭牌Url
    NSString *_zhengJiUrl;//整机url
    UITapGestureRecognizer * tapGesture;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)UIScrollView * bgScrollview;
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,copy)NSString * chanDiText;//产地
@property(nonatomic,copy)NSString * chengSeText;//成色
@property(nonatomic,copy)NSString * chengSeCode;
@property(nonatomic,strong)UIButton * lastBtn;//记录照片按钮
@property(nonatomic,strong)UIButton * buton1;
@end

@implementation ScanCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //搜索按钮
    UIButton* _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"提交" forState:0];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    [_rightBtn setTitleColor:[UIColor redColor] forState:0];
    [_rightBtn addTarget:self action:@selector(tijaioBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
    if (_tagg==2) {
       self.navigationItem.rightBarButtonItems=@[rightBtn];
    }

   
    
    
    if (_tagg==2) {
        _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)]; 
    }else{
        _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-44)];
    }
   
    _bgScrollview.delegate=self;
    [self.view addSubview:_bgScrollview];
    if (_tagg==2) {
            self.title=@"修改";
    }else{
         self.backHomeBtn.hidden=YES;
        //搜索按钮
        UIButton*rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitle:@"发布" forState:0];
        [rightBtn setTitleColor:[UIColor redColor] forState:0];
        rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        rightBtn.frame=CGRectMake(0, 0, 50, 15);
        [rightBtn addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightBtnn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems=@[rightBtnn];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lianjieClink:) name:@"pianyi" object:nil];

    NSArray * arr1 =@[@"标题",@"名称",@"数量",@"型号",@"价格"];
    NSArray * arr2 =@[@"产地",@"成色"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    [self CreatTableView];
   
}
#pragma mark --点击了提交
-(void)tijaioBtn{
    NSLog(@"点击了提交");
    //标题
    ScanCodeCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //名称
    ScanCodeCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    //数量
    ScanCodeCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    //型号
    ScanCodeCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //价格
    ScanCodeCell *cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    NSLog(@"标题%@",cell0.textfield.text);
    NSLog(@"名称%@",cell1.textfield.text);
    NSLog(@"数量%@",cell2.textfield.text);
    NSLog(@"型号%@",cell3.textfield.text);
    NSLog(@"价格%@",cell4.textfield.text);
    

    //详细信息
    NSLog(@"详细信息%@",textViewText.text);
    //成色
    
    NSLog(@"成色%@",[self stringText:_chengSeCode Text2:_model.chengseCode]);
    //产地
    NSLog(@"产地%@",[self stringText:_chanDiText Text2:_model.addressName]);
   
    
    
    
    
    //铭牌照片
    NSLog(@"铭牌照片地址%@",[ToolClass isString:_mingPaiUrl]);
    //整机照片
    NSLog(@"整机照片地址%@",[ToolClass isString:_zhengJiUrl]);

    [Engine1 xiuGaiChanPinMessageXiangQingTitle:cell0.textfield.text ProductName:cell1.textfield.text Count:cell2.textfield.text Type:cell3.textfield.text ExpectPrice:cell4.textfield.text ProductLocation:[self stringText:_chanDiText Text2:_model.addressName] Degree:[self stringText:_chengSeCode Text2:_model.chengseCode] Description:textViewText.text JingJiPeope:[NSString stringWithFormat:@"%@",_model.jingjiID] Image1:[ToolClass isString:_mingPaiUrl] Image2:[ToolClass isString:_zhengJiUrl] MessageID:_model.messageID success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
         [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        if ([item1 isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
           
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark --通知清空数据
-(void)lianjieClink:(NSNotification*)notification{
    NSLog(@"通知清空了");
    //标题
    ScanCodeCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //名称
    ScanCodeCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    //数量
    ScanCodeCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    //型号
    ScanCodeCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //价格
    ScanCodeCell *cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    //产地
    ScanCodeCell *cell5 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //成色
    ScanCodeCell *cell6 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
   
     cell0.textfield.text=@"";
     cell1.textfield.text=@"";
     cell2.textfield.text=@"";
     cell3.textfield.text=@"";
     cell4.textfield.text=@"";
     cell5.textfield.text=@"";
     cell6.textfield.text=@"";
    textViewText.text=@"请您说出商品名称,编号";
    textViewText.alpha=.6;
   _chengSeText=@"";
    _chanDiText=@"";
    [_lastBtn setBackgroundImage:[UIImage imageNamed:@"fabu_pic"] forState:0];;
     [_buton1 setBackgroundImage:[UIImage imageNamed:@"fabu_pic"] forState:0];;
    [_tableView reloadData];

}
-(void)CreatTableView{
    _tableView=[[UITableView alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.bounces=NO;
    [_bgScrollview sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_bgScrollview,0)
    .heightIs(50*7+10);
    [self CreatXiangXiMessage];
    
 
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tableView endEditing:YES];
}



-(void)tap:(UITapGestureRecognizer*)tap{
    NSLog(@"点击了");
    [_tableView endEditing:YES];
    [_view1 endEditing:YES];
    [_view2 endEditing:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_nameArray[section]  count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    ScanCodeCell * cell =[ScanCodeCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textfield.placeholder=@"请选择填写或者语音";
            cell.yuYinBtn.hidden=NO;
            if (_model) {
                cell.textfield.text=_model.titleName;
            }
        }else if (indexPath.row==1){
            cell.textfield.placeholder=@"请填写产品名称";
            if (_model) {
                cell.textfield.text=_model.nikeName;
            }
        }else if (indexPath.row==2){
             cell.textfield.keyboardType=UIKeyboardTypeNumberPad;
             cell.textfield.placeholder=@"请填写产品数量";
            if (_model) {
                cell.textfield.text=_model.numName;
            }
        }else if (indexPath.row==3){
            cell.textfield.placeholder=@"请填写产品型号";
            if (_model) {
                cell.textfield.text=_model.xingHaoName;
            }
        }else{
            cell.textfield.placeholder=@"请填写产品价格";
            if (_model) {
                cell.textfield.text=_model.priceName;
            }
        }
    }else{
        cell.textfield.enabled=NO;
        cell.textfield.textAlignment=2;
        [cell sd_addSubviews:@[cell.textfield]];
        cell.textfield.sd_layout
        .rightSpaceToView(cell,30);
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            //产地
            cell.textfield.text=[self stringText:_chanDiText Text2:_model.addressName];
            
//            if (_model) {
//                cell.textfield.text=_model.addressName;
//            }
           
        }else if (indexPath.row==1){
            //成色
            cell.textfield.text=[self stringText:_chengSeText Text2:_model.chengseName];//_chengSeText;
//            if (_model) {
//                cell.textfield.text=_model.chengseName;
//            }
        }
    }
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            //产地
            CityChooseVC * vc =[CityChooseVC new];
            vc.citynameBlock=^(NSString*name,NSString*code,NSString*shengCode){
                _chanDiText=name;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //成色
            ChengSeViewController * vc =[ChengSeViewController new];
            vc.chengSeBlock=^(NSString*chengse,NSString*chengSeCode){
                _chengSeText=chengse;
                _chengSeCode=chengSeCode;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//text1是从后面界面传过来的，text2是从上个界面过来的_model
-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * xx;
    if (text1) {
        xx=text1;
    }else{
        xx=text2;
    }
    
    return xx;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


#pragma mark --详细信息
-(void)CreatXiangXiMessage{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(_bgScrollview,0)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_tableView,5)
    .heightIs(100);
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [_view1 addGestureRecognizer:tap];
    //详细信息
    UILabel * xiangXi =[UILabel new];
    xiangXi.text=@"详细信息";
    xiangXi.alpha=.7;
    xiangXi.font=[UIFont systemFontOfSize:16];
    [_view1 sd_addSubviews:@[xiangXi]];
    xiangXi.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,10)
    .heightIs(20);
    [xiangXi setSingleLineAutoResizeWithMaxWidth:200];
    //线
    UIView * lineView =[UIView new];
    lineView.backgroundColor=COLOR;
    //lineView.alpha=.7;
    [_view1 sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(_view1,0)
    .rightSpaceToView(_view1,0)
    .topSpaceToView(xiangXi,10)
    .heightIs(1);
    //语音按钮
    UIButton * yuyinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [yuyinBtn setImage:[UIImage imageNamed:@"fabu_yuyin"] forState:0];
    [_view1 sd_addSubviews:@[yuyinBtn]];
    yuyinBtn.sd_layout
    .rightSpaceToView(_view1,15)
    .centerYEqualToView(xiangXi)
    .widthIs(32/2)
    .heightIs(47/2);
    
    //uitextview
    textViewText =[UITextView new];
    textViewText.delegate=self;
    textViewText.text=@"请您说出商品名称，编号";
    if (_model) {
         textViewText.text=_model.xiangXiName;
    }
    textViewText.alpha=.6;
    textViewText.font=[UIFont systemFontOfSize:14];
    [_view1 sd_addSubviews:@[textViewText]];
    textViewText.sd_layout
    .leftEqualToView(xiangXi)
    .topSpaceToView(lineView,5)
    .rightSpaceToView(_view1,15)
    .heightIs(80);
    [_view1 setupAutoHeightWithBottomView:textViewText bottomMargin:10];
    [self CreatView2];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --创建上传图片
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [_bgScrollview sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftEqualToView(_view1)
    .rightSpaceToView(_bgScrollview,0)
    .topSpaceToView(_view1,5);
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    [_view2 addGestureRecognizer:tap];
    //详细信息
    UILabel * xiangXi =[UILabel new];
    xiangXi.text=@"上传图片";
    xiangXi.alpha=.7;
    xiangXi.font=[UIFont systemFontOfSize:16];
    [_view2 sd_addSubviews:@[xiangXi]];
    xiangXi.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,10)
    .heightIs(20);
    [xiangXi setSingleLineAutoResizeWithMaxWidth:200];
    NSArray * arr =@[@"铭牌照片",@"整机照片"];
    NSArray * imageArr =@[[NSString stringWithFormat:@"%@",_model.imageurl2],[NSString stringWithFormat:@"%@",_model.imageurl]];
    //上传图片2个btn
    for (int i =0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"fabu_pic"] forState:0];
        if (_tagg==2) {
            [btn setBackgroundImageForState:0 withURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"fabu_pic"]];
        }
        btn.tag=i;
        _lastBtn=btn;
        if (i==0) {
            _buton1=btn;
        }
        UILabel * label =[UILabel new];
        label.font=[UIFont systemFontOfSize:13];
        label.alpha=.6;
        label.text=arr[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 sd_addSubviews:@[btn,label]];
        btn.sd_layout
        .leftSpaceToView(xiangXi,5+(91+30)*i)
        .topSpaceToView(xiangXi,0)
        .widthIs(186/2)
        .heightIs(140/2);
      
        label.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn,0)
        .heightIs(20);
        [label setSingleLineAutoResizeWithMaxWidth:120];
        [_view2 setupAutoHeightWithBottomView:label bottomMargin:10];
        
    }
     __weak __typeof(self)weakSelf = self;
    _view2.didFinishAutoLayoutBlock=^(CGRect rect){
        weakSelf.bgScrollview.contentSize=CGSizeMake(ScreenWidth, rect.origin.y+rect.size.height+10);
    };
    
}
-(void)btnClick:(UIButton*)btn{
    _lastBtn=btn;
    [self dioayongXiangCe];
}



#pragma mark --调用系统相册
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"数看啊%lu",_lastBtn.tag);
    [_lastBtn setBackgroundImage:image forState:0];
    [self shangChuanImage:image tagg:_lastBtn.tag];
   
}



#pragma mark --上传图片获取地址
-(void)shangChuanImage:(UIImage*)image tagg:(NSInteger)tag{
    NSData * imgData=  UIImageJPEGRepresentation(image, 0);
   // [LCProgressHUD showLoading:@"正在上传,请稍后..."];
    //type:1.产品 2新闻 3.用户
    [Engine1 ShangChuanImageData:imgData Type:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSString * urlImage =[dic objectForKey:@"Item2"];
            NSLog(@"数值乘车%@",urlImage);
            if (_lastBtn.tag==0) {
                _mingPaiUrl=urlImage;
            }else{
                _zhengJiUrl=urlImage;
            }
             [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}








#pragma mark --发布按钮
-(void)fabu{
    //标题
    ScanCodeCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //名称
    ScanCodeCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    //数量
    ScanCodeCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    //型号
    ScanCodeCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //价格
    ScanCodeCell *cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
     NSLog(@"标题%@",cell0.textfield.text);
     NSLog(@"名称%@",cell1.textfield.text);
     NSLog(@"数量%@",cell2.textfield.text);
     NSLog(@"型号%@",cell3.textfield.text);
     NSLog(@"价格%@",cell4.textfield.text);
    //详细信息
    NSLog(@"详细信息%@",textViewText.text);
    //成色
    NSLog(@"成色%@",[ToolClass isString:_chengSeText]);
    //产地
    NSLog(@"产地%@",[ToolClass isString:_chanDiText]);
    //铭牌照片
    NSLog(@"铭牌照片地址%@",[ToolClass isString:_mingPaiUrl]);
    //整机照片
    NSLog(@"整机照片地址%@",[ToolClass isString:_zhengJiUrl]);
    NSMutableDictionary * dataDic =[NSMutableDictionary new];
      [dataDic setObject:cell0.textfield.text forKey:@"标题"];
      [dataDic setObject:cell1.textfield.text forKey:@"名称"];
      [dataDic setObject:cell2.textfield.text forKey:@"数量"];
      [dataDic setObject:cell3.textfield.text forKey:@"型号"];
      [dataDic setObject:cell4.textfield.text forKey:@"价格"];
      [dataDic setObject:[ToolClass isString:_chanDiText] forKey:@"产地"];
     [dataDic setObject:textViewText.text forKey:@"描述"];
      [dataDic setObject:[ToolClass isString:_chengSeCode] forKey:@"成色"];
      [dataDic setObject:[ToolClass isString:_mingPaiUrl] forKey:@"铭牌照片"];
      [dataDic setObject:[ToolClass isString:_zhengJiUrl] forKey:@"整机照片"];
     [ToolClass savePlist:dataDic name:@"入驻发布"];
    
    NSDictionary * dicc =[ToolClass duquPlistWenJianPlistName:@"入驻发布"];
    if (dicc) {
        NSLog(@"取出字典个数%lu",dicc.count);
        PublicTypeVC * vc =[PublicTypeVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [LCProgressHUD showMessage:@"请完善信息在发布"];
    }
    
//
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    CGFloat rects = _bgScrollview.frame.size.height - (textView.frame.origin.y + textView.frame.size.height + 216 +50);
    
    NSLog(@"aa%f>>>%f",rects,(textView.frame.origin.y + textView.frame.size.height + 216 +50));
    [_bgScrollview  setContentOffset:CGPointMake(0, 266) animated:YES];
    _bgScrollview.scrollEnabled=NO;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [_bgScrollview  setContentOffset:CGPointMake(0, 0) animated:YES];
    
    _bgScrollview.scrollEnabled=YES;
    return YES;
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
