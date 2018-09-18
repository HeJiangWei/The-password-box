//
//  PopView.m
//  ButtonPopMen
//
//  Created by Macx on 16/7/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "PopView.h"
@interface PopView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger tagg;
    CGFloat xx;
    CGFloat yy;
    CGFloat kk;
    CGFloat gg;
}
@property(nonatomic,retain)UITableView * tableView;
@end
@implementation PopView
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        tagg=1000;
       // self.backgroundColor=[UIColor redColor];
        self.layer.cornerRadius=10;
        self.clipsToBounds=YES;
        xx=self.frame.origin.x;
        yy=self.frame.origin.y;
        kk=self.frame.size.width;
        gg=self.frame.size.height;
        [self CreatTableView];
    }
    
    return self;
    
}
-(void)CreatTableView
{
    
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        //self.tableView.alpha=.7;
        self.tableView.scrollEnabled=NO;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, cell.frame.size.width,30)];
        label.tag=10;
        [cell addSubview:label];
        
        UIImageView * label2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 12,12)];
        label2.image=[UIImage imageNamed:@"对勾"];
        label2.hidden=YES;
        label2.tag=20;
        [cell addSubview:label2];
        
        
    }
    UILabel * lable =[cell viewWithTag:10];
    UIImageView * lable2 =[cell viewWithTag:20];
    
    lable2.hidden=YES;
    lable.text=_dataArray[indexPath.row];
    //lable.textAlignment=1;
    lable.font=[UIFont systemFontOfSize:15];
    cell.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    lable.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (tagg==indexPath.row) {
        cell.backgroundColor=[UIColor colorWithRed:61/255.0 green:141/255.0 blue:254/255.0 alpha:1];
        lable.backgroundColor=[UIColor colorWithRed:61/255.0 green:141/255.0 blue:254/255.0 alpha:1];
        lable2.hidden=NO;
        
    }
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    tagg=indexPath.row;
    [self.tableView reloadData];
    self.btnNameBlock(_dataArray[indexPath.row]);
    [self hide];
   
}

- (void)show
{
    
    //取消动画效果
   // self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height+250);
   // self.frame=CGRectMake(xx,yy, kk, 0);
   // self.tableView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
       [UIView animateWithDuration:0.5 animations:^(void) {
            //self.transform = CGAffineTransformIdentity;
//            self.frame=CGRectMake(xx, yy, kk, gg);
//            self.tableView.frame=CGRectMake(0, 0, self.frame.size.width, 30*_dataArray.count);
           self.hidden=NO;
        } completion:^(BOOL isFinished) {
        }];
}
- (void)hide
{    //取消了动画效果
        [UIView animateWithDuration:0.5 animations:^(void) {
//        self.tableView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
//        self.frame=CGRectMake(xx,yy, kk, 0);
            self.hidden=YES;
        } completion:^(BOOL isFinished) {
        }];
}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self];
//    
//    //坐标： location.x, location.y
//    NSLog(@"%f...%f",location.x,location.y);
//    // .....
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
