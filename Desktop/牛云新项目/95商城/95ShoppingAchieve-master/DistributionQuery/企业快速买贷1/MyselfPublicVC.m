//
//  MyselfPublicVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyselfPublicVC.h"
#import "MyselfPublicCell.h"
#import "YuYinPublicVC.h"
#import "HangYeVC.h"
#import "CityChooseVC.h"
@interface MyselfPublicVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIButton * camaBtn;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)UIButton * publicBtn;
@property(nonatomic,copy)NSString * hangYeCode;//记录选择的行业code
@property(nonatomic,copy)NSString * hangYeName;//记录选择的行业name
@property(nonatomic,copy)NSString * diquText;//记录选择的城市
@property(nonatomic,copy)NSString * cityCode;//记录选择的城市ID
@property(nonatomic,copy)NSString * urlStr;//记录上传的照片url
@end

@implementation MyselfPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatNameArray];
    [self CreatTableView];
}
#pragma mark --创建数据源
-(void)CreatNameArray{
    NSArray * arr1 =@[@"标题",@"数量",@"价格",@"手机号"];
    NSArray * arr2 =@[@"所属行业",@"所在地"];
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    _view3=[UIView new];
    _view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_view3];
}



#pragma mark --创建表
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 64+50, ScreenWidth, 6*50+5+5);
    _tableView.bounces=NO;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
    [self CreatView3];

    


}

#pragma mark --创建图片
-(void)CreatView3{
    _view3.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_tableView,5)
    .heightIs(120);
    //上传图片
    UILabel * nameLabel =[[UILabel alloc]init];
    nameLabel.text=@"上传图片";
    nameLabel.alpha=.7;
    nameLabel.font=[UIFont systemFontOfSize:16];
    [_view3 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(_view3,15)
    .topSpaceToView(_view3,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    //相机按钮
    camaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [camaBtn setBackgroundImage:[UIImage imageNamed:@"fabu_pic"] forState:0];
    [camaBtn addTarget:self action:@selector(camaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view3 sd_addSubviews:@[camaBtn]];
    camaBtn.sd_layout
    .leftSpaceToView(nameLabel,25)
    .topSpaceToView(nameLabel,0)
    .widthIs(186/2)
    .heightIs(140/2);
    //创建Label
    UILabel * label =[UILabel new];
    label.text=@"温馨提示:\n上传产品照片,\n有助于详细展示产品！";
    label.numberOfLines=0;
    label.alpha=.6;
    label.textAlignment=1;
    label.font=[UIFont systemFontOfSize:13];
    [_view3  sd_addSubviews:@[label]];
    label.sd_layout
    .rightSpaceToView(_view3,20)
    .centerYEqualToView(camaBtn)
    .autoHeightRatio(0);
    [label setSingleLineAutoResizeWithMaxWidth:100];
    
    //立即发布
    _publicBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_publicBtn setImage:[UIImage imageNamed:@"fabu_bt"] forState:0];
    [_publicBtn addTarget:self action:@selector(fabu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[_publicBtn]];
    _publicBtn.sd_layout
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .topSpaceToView(_view3,40)
    .heightIs(40);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_nameArray[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    MyselfPublicCell * cell =[MyselfPublicCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        cell.textField.delegate=self;
        if (indexPath.row==0) {
            cell.textField.placeholder=@"请选择填写或者语音";
            cell.yuYinBtn.hidden=NO;
            [cell.yuYinBtn addTarget:self action:@selector(yuyinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if (indexPath.row==1){
            cell.textField.placeholder=@"请填写产品数量";
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        }else if (indexPath.row==2){
            cell.textField.placeholder=@"请填写产品价格";
        }else{
             cell.textField.placeholder=@"请填写手机号";
            cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        }
    }else{
        cell.textField.enabled=NO;
        cell.textField.textAlignment=2;
        [cell sd_addSubviews:@[cell.textField]];
        cell.textField.sd_layout
        .widthIs(180)
        .rightSpaceToView(cell,25);
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.textField.text=_hangYeName;
        }else{
            cell.textField.text=_diquText;
        }
      
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
           //所属行业
            HangYeVC * vc =[HangYeVC new];
            vc.hangYeNameCidBlock=^(NSString*name,NSString*idd){
                _hangYeCode=idd;
                _hangYeName=name;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //所在地
            CityChooseVC * vc =[CityChooseVC new];
            vc.citynameBlock=^(NSString *name,NSString*shiCode,NSString*shengCodea){
                _diquText=name;
                _cityCode=shiCode;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 5;
}
#pragma mark --语音按钮
-(void)camaBtnClick:(UIButton*)btn{
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
    [camaBtn setBackgroundImage:image forState:0];
    [self shangChuanImage:image];
    
}



#pragma mark --上传图片获取地址
-(void)shangChuanImage:(UIImage*)image {
    NSData * imgData=  UIImageJPEGRepresentation(image, 0);
    // [LCProgressHUD showLoading:@"正在上传,请稍后..."];
    //type:1.产品 2新闻 3.用户
    [Engine1 ShangChuanImageData:imgData Type:@"1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSString * urlImage =[dic objectForKey:@"Item2"];
            NSLog(@"数值乘车%@",urlImage);
            _urlStr=urlImage;
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma  mark --发布按钮
-(void)fabu:(UIButton*)btn{
    NSLog(@"你点击发布了");
    //标题
    MyselfPublicCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //数量
    MyselfPublicCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    //价格
    MyselfPublicCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    //手机号
    MyselfPublicCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //行业 _hangYeName,,_hangYeCode
   //所在地 _diquText _cityCode
    //图片url _urlStr
    
    NSLog(@"标题>>%@",cell0.textField.text);
    NSLog(@"数量>>%@",cell1.textField.text);
    NSLog(@"价格>>%@",cell2.textField.text);
    NSLog(@"手机号>>%@",cell3.textField.text);
    NSLog(@"行业名字%@>>>行业ID=%@",_hangYeName,_hangYeCode);
    NSLog(@"所在地名字>>%@>>>所在地code=%@",_diquText,_cityCode);
    NSLog(@"图片url>>%@",_urlStr);
    [LCProgressHUD showLoading:@"发布中..."];
    [Engine1 qiYeKuaiSuPublicTitleStr:cell0.textField.text Count:cell1.textField.text PriceStr:cell2.textField.text PhoneNumber:cell3.textField.text HangYeID:[ToolClass isString:_hangYeCode] DiQuCode:[ToolClass isString:_cityCode] imageUrlStr:[ToolClass isString:_urlStr] success:^(NSDictionary *dic) {
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









-(void)yuyinBtnClick:(UIButton*)btn{
    YuYinPublicVC * vc =[[YuYinPublicVC alloc]init];
    vc.tagg=0;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_tableView endEditing:YES];
    [_view3 endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_tableView  endEditing:YES];
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
