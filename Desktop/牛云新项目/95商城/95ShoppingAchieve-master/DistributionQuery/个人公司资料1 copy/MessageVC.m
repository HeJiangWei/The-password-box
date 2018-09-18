//
//  MessageVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MessageVC.h"
#import "MessageCell.h"
#import "CityChooseVC.h"
#import "HangYeVC.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray*nameArray;
@property(nonatomic,copy)NSString * diquText;//地区的名字
@property(nonatomic,copy)NSString * shengCode;//省份的code
@property(nonatomic,copy)NSString* cityCode;//城市的code
@property(nonatomic,copy)NSString * hangYeName;//行业的名字
@property(nonatomic,copy)NSString * hangYeCode;//行业code
@property(nonatomic,strong)NSDictionary * dataDic;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"token>>>%@",[NSUSE_DEFO objectForKey:@"token"]);
    NSLog(@"mid>>>%@",[NSUSE_DEFO objectForKey:@"mid"]);
    if (_tagg==0) {
       self.title=@"个人资料";
    }else{
        self.title=@"公司资料";
    }
    [self tijiaoBtn];
    [self CreatNameArr];//数据源
    [self CreatTableView];
    
//   XiuGaiMenZiLiaoNiCheng 
    
}
#pragma mark --提交按钮
-(void)tijiaoBtn{
    //搜索按钮
   UIButton* _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"提交" forState:0];
    [_rightBtn setTitleColor:[UIColor redColor] forState:0];
    [_rightBtn addTarget:self action:@selector(tijiaoBtn:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtn];

}
#pragma mark --提价
-(void)tijiaoBtn:(UIButton*)btn{
    if (_tagg==0) {
        //个人资料
        MessageCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        MessageCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

        NSLog(@"昵称%@",cell1.textfield.text);
        NSLog(@"姓名%@",cell2.textfield.text);
        NSLog(@"省份%@",_shengCode);
        NSLog(@"城市%@",_cityCode);
        ;
        [LCProgressHUD showLoading:@"正在提交，请稍后..."];
        [Engine1 XiuGaiMenZiLiaoNiCheng:cell1.textfield.text Name:cell2.textfield.text Sheng:[self stringText:_shengCode Text2:[_dataDic objectForKey:@"M_Province"]] City:[self stringText:_cityCode Text2:[_dataDic objectForKey:@"M_City"]] Xian:nil success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSDictionary * item3Dic =[dic objectForKey:@"Item3"];
                [self saveSomeMessageDic:item3Dic];
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        //公司资料
       
        MessageCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSLog(@"公司名字=%@",cell1.textfield.text);
        NSLog(@"行业id=%@",_hangYeCode);
        NSLog(@"省份城市%@",_diquText);
      //  NSLog(@"城市%@",_cityCode);
        [Engine1 XiuGaiCompanyZiLiaoName:cell1.textfield.text Address:[self stringText:_diquText Text2:[_dataDic objectForKey:@"M_Address"]] HangYeID:[self stringText:_hangYeCode Text2:[_dataDic objectForKey:@"M_Category"]] success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSDictionary * item3dic =[dic objectForKey:@"Item3"];
                [self saveSomeMessageDic:item3dic];
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    
}
#pragma mark --存储登录信息
-(void)saveSomeMessageDic:(NSDictionary*)dic{
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
#pragma mark --创建数据源
-(void)CreatNameArr{
    NSArray * arr1;
    NSArray * arr2;
     _dataDic =[ToolClass duquPlistWenJianPlistName:@"Login"];
    NSLog(@"有没有%@",_dataDic);
    if (_tagg==0) {
         arr1 =@[@"昵称",@"真实姓名"];
         arr2 =@[@"所在地区"];
    }else{
        arr1 =@[@"公司名字",@"经营行业"];
        arr2 =@[@"所在场所"];
        
    }
    
    
   
   
    _nameArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
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
    return _nameArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    MessageCell * cell =[MessageCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.nameLabel.text=_nameArray[indexPath.section][indexPath.row];
    if (_tagg==0) {
        //个人资料
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                NSString * nike =[_dataDic objectForKey:@"M_NickName"];
                if (nike==nil) {
                  cell.textfield.placeholder=@"请填写昵称";
                }else{
                  cell.textfield.text=nike;
                    cell.textfield.sd_layout.widthIs(150);
                }
                
            }else{
                 NSString * name =[_dataDic objectForKey:@"M_RealName"];
                if (name==nil) {
                    cell.textfield.placeholder=@"请填写姓名";
                }else{
                    cell.textfield.text=name;
                }
                
            }
           
        }else{
            NSString * name =[NSString stringWithFormat:@"%@-%@",[_dataDic objectForKey:@"M_ProvinceName"],[_dataDic objectForKey:@"M_CityName"]];
            cell.textfield.enabled=NO;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textfield.textAlignment=2;
            [cell sd_addSubviews:@[cell.textfield]];
            cell.textfield.sd_layout
            .widthIs(180)
            .rightSpaceToView(cell,25);
            cell.textfield.text=[self stringText:_diquText Text2:name];
        }
        
        
    }else{
        //公司资料
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                //公司名字
                NSString * name =[_dataDic objectForKey:@"M_CompanyName"];
                if (name) {
                    cell.textfield.text=name;
                }else{
                     cell.textfield.placeholder=@"请填写公司名字";
                }
              
                cell.textfield.sd_layout.widthIs(250);
            }else{
                //经营行业
                cell.textfield.enabled=NO;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                cell.textfield.textAlignment=2;
                [cell sd_addSubviews:@[cell.textfield]];
                cell.textfield.sd_layout
                .widthIs(180)
                .rightSpaceToView(cell,25);
                cell.textfield.text=[self stringText:_hangYeName Text2:[_dataDic objectForKey:@"M_CategoryName"]];//_hangYeName;
            }
            
        }else{
           cell.textfield.enabled=NO;
            cell.textfield.textAlignment=2;
            [cell sd_addSubviews:@[cell.textfield]];
            cell.textfield.sd_layout
            .widthIs(180)
           .rightSpaceToView(cell,25);
            NSString * name =[_dataDic objectForKey:@"M_Address"];
            cell.textfield.text=[self stringText:_diquText Text2:name];   ;
           cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }

        
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tagg==0) {
        //个人资料
        if (indexPath.section==0) {
        }else{
            //所在地区
            CityChooseVC * vc =[CityChooseVC new];
            vc.citynameBlock=^(NSString *name,NSString*shiCode,NSString*shengCodea){
                _diquText=name;
                _cityCode=shiCode;
                _shengCode=shengCodea;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //公司资料
        if (indexPath.section==0) {
            if (indexPath.row==1) {
                HangYeVC * vc =[HangYeVC new];
                vc.hangYeNameCidBlock=^(NSString*name,NSString*idd){
                    _hangYeCode=idd;
                    _hangYeName=name;
                    [_tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            //所在场所
            CityChooseVC * vc =[CityChooseVC new];
            vc.citynameBlock=^(NSString *name,NSString*shiCode,NSString*shengCodea){
                _diquText=name;
                _cityCode=shiCode;
                _shengCode=shengCodea;
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
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
