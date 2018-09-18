//
//  ChoosePeopleCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChoosePeopleCell.h"
@interface ChoosePeopleCell()
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * bianHaoLab;
@property(nonatomic,strong)UILabel *ziYuanLab;
@property(nonatomic,strong)UILabel * fuzeLab;
@property(nonatomic,strong)UIButton *hangYeBtn1;
@property(nonatomic,strong)UIButton *hangYeBtn2;
@property(nonatomic,strong)UIButton *hangYeBtn3;
@end
@implementation ChoosePeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    ChoosePeopleCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ChoosePeopleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  self.backgroundColor=[UIColor colorWithRed:254/255.0 green:251/255.0 blue:224/255.0 alpha:1];
        [self CreatStar];
    }
    return self;
}
-(void)CreatStar{
    /*
     headImage;
     bianHaoLab;
     ziYuanLab;
     fuzeLab;
     hangYe1;
     hangYe2;
     hangYe3;
     duiGouBtn;//对勾btn
     */
    _headImage=[UIImageView new];
    _bianHaoLab=[UILabel new];
    _ziYuanLab=[UILabel new];
    _fuzeLab=[UILabel new];
    _hangYeBtn1=[UIButton new];
    _hangYeBtn2=[UIButton new];
    _hangYeBtn3=[UIButton new];
    _duiGouBtn=[UIButton new];
    [self.contentView sd_addSubviews:@[_headImage,_bianHaoLab,_ziYuanLab,_fuzeLab]];
    [self.contentView sd_addSubviews:@[_hangYeBtn1,_hangYeBtn2,_hangYeBtn3,_duiGouBtn]];
    //属性
    [self shuxingLabel:_bianHaoLab];
    [self shuxingLabel:_ziYuanLab];
    [self shuxingLabel:_fuzeLab];
    _headImage.sd_cornerRadius=@(75/2);
     _hangYeBtn1.titleLabel.font=[UIFont systemFontOfSize:14];
     _hangYeBtn2.titleLabel.font=[UIFont systemFontOfSize:14];
     _hangYeBtn3.titleLabel.font=[UIFont systemFontOfSize:14];
    _hangYeBtn1.backgroundColor=JXColor(245, 202, 203, 1);
    _hangYeBtn2.backgroundColor=JXColor(245, 202, 203, 1);
    _hangYeBtn3.backgroundColor=JXColor(245, 202, 203, 1);
    [_hangYeBtn1 setTitleColor: JXColor(243, 86, 93, 1) forState:0];
     [_hangYeBtn2 setTitleColor:JXColor(243, 86, 93, 1) forState:0];
     [_hangYeBtn3 setTitleColor:JXColor(243, 86, 93, 1) forState:0];
    _hangYeBtn1.sd_cornerRadius=@(5);
     _hangYeBtn2.sd_cornerRadius=@(5);
     _hangYeBtn3.sd_cornerRadius=@(5);
   
    //赋值
    _headImage.image=[UIImage imageNamed:@"my_photo"];
    _bianHaoLab.text=@"编号01";
    _ziYuanLab.text=@"资源数量  10";
    _fuzeLab.text=@"负责行业";
    [_hangYeBtn1 setTitle:@"机械" forState:0];
    [_hangYeBtn2 setTitle:@"注册机" forState:0];
    [_hangYeBtn3 setTitle:@"注塑机" forState:0];
    [_duiGouBtn setBackgroundImage:[UIImage imageNamed:@"shoucnag_bt1"] forState:0];
     [_duiGouBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_bt_click"] forState:UIControlStateSelected];//28 28
    
    [self frameLabel];
    
}
-(void)frameLabel{
    //头像
    _headImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(75)
    .heightIs(75);
    //编号
    _bianHaoLab.sd_layout
    .leftSpaceToView(_headImage,15)
    .topSpaceToView(self.contentView,20)
    .heightIs(20);
    [_bianHaoLab setSingleLineAutoResizeWithMaxWidth:180];
    //对勾按钮
    _duiGouBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_headImage)
    .widthIs(14)
    .heightIs(14);
    
    //资源数量
    _ziYuanLab.sd_layout
    .rightSpaceToView(_duiGouBtn,10)
    .centerYEqualToView(_bianHaoLab)
    .heightIs(20);
    [_ziYuanLab setSingleLineAutoResizeWithMaxWidth:180];
    //负责行业
    _fuzeLab.sd_layout
    .leftEqualToView(_bianHaoLab)
    .topSpaceToView(_bianHaoLab,15)
    .heightIs(20);
    [_fuzeLab setSingleLineAutoResizeWithMaxWidth:180];
    
    _hangYeBtn1.sd_layout
    .leftSpaceToView(_fuzeLab,10)
    .centerYEqualToView(_fuzeLab)
    .widthIs(100/2)
    .heightIs(46/2);
    
    _hangYeBtn2.sd_layout
    .leftSpaceToView(_hangYeBtn1,10)
    .centerYEqualToView(_fuzeLab)
    .widthRatioToView(_hangYeBtn1,1)
    .heightRatioToView(_hangYeBtn1,1);
    
    _hangYeBtn3.sd_layout
    .leftSpaceToView(_hangYeBtn2,10)
    .centerYEqualToView(_fuzeLab)
    .widthRatioToView(_hangYeBtn1,1)
    .heightRatioToView(_hangYeBtn1,1);


}

-(void)setModel:(ChoosePeopleModel *)model{
    _model=model;
    [_headImage setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"my_photo"]];
    _bianHaoLab.text=model.bianHaoName;
    _ziYuanLab.text=[NSString stringWithFormat:@"资源数量  %@",model.ziyuanNumber];
}
-(void)duiBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)shuxingLabel:(UILabel *)labe{
    labe.font=[UIFont systemFontOfSize:14];
    labe.alpha=.6;
}
@end
