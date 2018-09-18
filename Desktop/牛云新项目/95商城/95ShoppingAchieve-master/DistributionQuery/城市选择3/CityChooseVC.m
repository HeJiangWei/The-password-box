//
//  CityChooseVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/23.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "CityChooseVC.h"
#import "ChineseString.h"
#import "CityModel.h"
@interface CityChooseVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * dingWeiBtn;
    NSString * lastName;//用来记录获取定位城市的名字
}
@property(nonatomic,retain)UITableView * tableView;
@property NSMutableArray * dataSource;
@property NSMutableArray  * dataBase1;
@property(nonatomic,retain)NSMutableArray * dataCityName;
@property(nonatomic,retain)NSMutableArray * dataCityCode;
@property(nonatomic,retain)NSMutableArray * dataShengCode;

@end

@implementation CityChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"所在地区";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self positioning];
    [self CityDingWei];
    [self StarData];
    [self CreatTableView];
}
//定位服务
-(void)positioning{
    UILabel * bgview =[[UILabel alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 35)];
    bgview.text=@"   当前位置";
    bgview.font=[UIFont systemFontOfSize:16];
    bgview.backgroundColor=COLOR;
    [self.view addSubview:bgview];
    
    dingWeiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    dingWeiBtn.backgroundColor=[UIColor whiteColor];
    dingWeiBtn.frame=CGRectMake(0, 35+64, ScreenWidth, 44);
    [dingWeiBtn setTitleColor:[UIColor blackColor] forState:0];
    dingWeiBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    dingWeiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    dingWeiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [dingWeiBtn addTarget:self action:@selector(dingWeiButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dingWeiBtn];
    
    
    UILabel * label2 =[[UILabel alloc]initWithFrame:CGRectMake(0, 64+35+44, ScreenWidth, 35)];
    label2.text=@"   选择城市";
    label2.font=[UIFont systemFontOfSize:16];
    label2.backgroundColor=COLOR;
    [self.view addSubview:label2];
    
}

-(void)StarData{
    
    _dataCityName=[NSMutableArray new];
    _dataCityCode=[NSMutableArray new];
    _dataShengCode=[NSMutableArray new];
    [self CityDaga];
    
}
-(void)CityDaga{
    [LCProgressHUD showLoading:@"加载中..."];
    [Enginejw0803 getCityWithShengCode:@"0" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [LCProgressHUD hide];
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item3) {
                CityModel * md =[[CityModel alloc]initWithCityDic:dicc];
                [_dataCityName addObject:md.cityName];
                [_dataCityCode addObject:md.cityCode];
                [_dataShengCode addObject:md.cityShengCode];
            }
            _dataSource=[ChineseString IndexArray:_dataCityName];
            _dataBase1 =[ChineseString LetterSortArray:_dataCityName];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];

}
-(void)CreatTableView{
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+35+44+35, ScreenWidth, ScreenHeight-(64+35+44+35)) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}

//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _dataSource;
}
//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    
    // NSLog(@"%@-%ld",title,(long)index);
    
    for(NSString *character in _dataSource)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}

//返回section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [_dataSource count];
}
//返回每个section的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray * arr =_dataBase1[section];
    if (arr.count%4==0) {
        return arr.count/4;
        
    }
    else
    {
        return 1+arr.count/4;
    }
    
}
//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataSource objectAtIndex:section];
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray * arr=_dataBase1[indexPath.section];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSArray * subViews = [[NSArray alloc]initWithArray:cell.subviews];
    
    for (UIView *subView in subViews) {
        [subView removeFromSuperview];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGFloat xj =2;
    //    CGFloat yj =2;
    CGFloat k =(ScreenWidth-12-20)/4;
    CGFloat g = k/2;
    if (indexPath.row < arr.count/4)
    {
        for (int i=0; i< 4; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.backgroundColor=[UIColor clearColor];
            [button setTitle:arr[indexPath.row*4+i] forState:0];
            button.titleLabel.font=[UIFont systemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:0];
            button.frame=CGRectMake(xj+(k+xj)*i, 5, k, g);
            button.tag = indexPath.row*4+i;
            [button addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 , 0, 5)];
            [cell addSubview:button];
            
        }
    }
    else
    {
        for (int i=0; i< arr.count%4; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor=[UIColor clearColor];
            [button setTitleColor:[UIColor blackColor] forState:0];
            if (indexPath.row == 0) {
                [button setTitle:arr[i] forState:0];
                button.tag = i;
            }
            else
            {
                [button setTitle:arr[indexPath.row*4+i] forState:0];
                button.tag =indexPath.row*4+i;
            }
            [button addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font=[UIFont systemFontOfSize:14];;
            button.frame=CGRectMake(xj+(k+xj)*i, 5, k, g);
            [cell addSubview:button];
        }
    }
    
    
    
    
    return cell;
}

-(void)button1:(UIButton*)btn{
    
    UITableViewCell *cell = (UITableViewCell *)[btn superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSArray * arr=_dataBase1[indexPath.section];
    NSString * name =arr[btn.tag];
    //根据名字找到它在这个数组的索引
    for (int i = 0; i<_dataCityName.count; i++)
    {
        NSString * s =_dataCityName[i];
        //如果找到这个名字了，就输出索引
        if ([s isEqualToString:name])
        {
            // NSLog(@"索引%d",i);
            //根据索引取出对应的code
            NSString * code =_dataCityCode[i];
            NSString *shengCode=_dataShengCode[i];
             self.citynameBlock(name,code,shengCode);
            // NSLog(@">>>%@>>>%@",name,shengCode);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
}
#pragma mark -- 城市定位
-(void)CityDingWei
{
     NSLog(@"定位");
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        _coder = [[CLGeocoder alloc]init];
        _manager = [[CLLocationManager alloc] init] ;
        _manager.delegate = self;
        //设置定位精度
        _manager.desiredAccuracy=kCLLocationAccuracyBest;
        _manager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [_manager requestWhenInUseAuthorization];
        }
        // 开始定位
        [_manager startUpdatingLocation];
        
    }
    else
    {
        NSLog(@"定位服务不可用");
    }
    
    
}


//位置发生改变的时候调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"有没有");
    CLLocation * location =[locations lastObject];
    //维度
    CLLocationDegrees lat = location.coordinate.latitude;
    //精度
    CLLocationDegrees lon = location.coordinate.longitude;
    CLLocation * aLoc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
    //把经纬度反编译成具体的地址1.参数需要创建一个（上面）
    [_coder reverseGeocodeLocation:aLoc completionHandler:^(NSArray *placemarks, NSError *error) {
        //这里的CLplacemarks对象包含了所有的地址信息
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * mark, NSUInteger idx, BOOL *stop) {
            //这里需要把id obj，给成CLPlacemark *mark,
            // NSLog(@"具体的地址是%@",mark.addressDictionary);
            NSString * ss =[NSString stringWithFormat:@"%@-%@",[mark.addressDictionary objectForKey:@"State"],[mark.addressDictionary objectForKey:@"City"]];
            NSLog(@"有没有数据%@",ss);
            lastName=[mark.addressDictionary objectForKey:@"City"];
            [dingWeiBtn setTitle:ss forState:0];
            
        }];
        
    }];
    
}
-(void)dingWeiButton{
    
    // NSLog(@"%@",lastName);
    for (int i =0; i< _dataCityName.count;i++)
    {
        NSString * name =_dataCityName[i];
        if ([name isEqualToString:lastName])
        {
            //            NSLog(@"输出的个数%d",i);
            //            NSLog(@"定位城市的code=%@",_dataCityCode[i]);
            //            NSLog(@"定位城市省份code=%@",_dataShengCode[i]);
            self.citynameBlock(lastName,_dataCityCode[i],_dataShengCode[i]);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;//gg;
}
@end
