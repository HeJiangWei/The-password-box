//
//  SetViewController.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "SetViewController.h"
#import "MessageVC.h"
#import "MyRenZhengVC.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,copy)NSString * headUrl;//头像地址
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    [self getImageHead];
    [self CreatDataArr];//数据源
    [self CreatTableView];//表
}
#pragma mark --创建数据源
-(void)CreatDataArr{
    NSArray * arr1 =@[@"头像"];
    NSArray * arr2=@[@"个人资料",@"公司资料",@"我要认证"];
    NSArray * arr3 =@[@"退出"];
    _dataArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];
}

#pragma mark --获取头像
-(void)getImageHead{
    [Engine1 huoQuImageWithType:@"0" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * imageHead =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc  in imageHead) {
                _headUrl =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"Img_Url"]];
            }
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --创建表
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_dataArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * imageview =[UIImageView new];
        imageview.tag=1;
        [cell sd_addSubviews:@[imageview]];
    }
    UIImageView * imageview =(UIImageView *)[cell viewWithTag:1];
    cell.textLabel.text=_dataArray[indexPath.section][indexPath.row];
    cell.textLabel.alpha=.7;
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
//        imageview.image=[UIImage imageNamed:@"my_photo"];
        [imageview setImageWithURL:[NSURL URLWithString:_headUrl] placeholderImage:[UIImage imageNamed:@"my_photo"]];
        imageview.sd_cornerRadius=@(40);
        imageview.sd_layout
        .rightSpaceToView(cell,20)
        .centerYEqualToView(cell)
        .widthIs(80)
        .heightIs(80);
        
    }else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        //更换头像
        [self dioayongXiangCe];
    }
    else if (indexPath.section==1) {
        
        if (indexPath.row==2) {
            //我要认证
            MyRenZhengVC * vc =[MyRenZhengVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //个人资料、公司资料
            MessageVC * vc =[MessageVC new];
            vc.tagg=indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section==2){
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否退出" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
            //删除Login.plist文件
            [ToolClass deleagtePlistName:@"Login"];
            //移除token
            [NSUSE_DEFO removeObjectForKey:@"token"];
            [NSUSE_DEFO removeObjectForKey:@"mid"];
            [NSUSE_DEFO synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
        [actionView addAction:action2];
         [actionView addAction:action1];
        [self presentViewController:actionView animated:YES completion:nil];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 100;
    }else{
       return 50;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --调用系统相册
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    // [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //  NSLog(@"输出%@",editingInfo);
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     UIImageView * imageview =(UIImageView *)[cell viewWithTag:1];
    imageview.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self shangChuanImage:image];
}
#pragma mark --上传图片
-(void)shangChuanImage:(UIImage*)image{
     NSData * imgData=  UIImageJPEGRepresentation(image, 0);
    [LCProgressHUD showLoading:@"正在上传,请稍后..."];
    //type:1.产品 2新闻 3.用户
    [Engine1 ShangChuanImageData:imgData Type:@"3" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSString * urlImage =[dic objectForKey:@"Item2"];
            [self saveImage:urlImage];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --保存图片
-(void)saveImage:(NSString*)url{
    /*
     type
     0.头像 1.身份证 2营业执照 3.税务登记证 4.实地图片
     */
    [Engine1 saveImageType:@"0" urlStr:url success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
@end
