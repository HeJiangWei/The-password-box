//
//  YouZhiShangHuCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YouZhiShangHuCell.h"
@interface YouZhiShangHuCell()
@property(nonatomic,strong)UIImageView * leftImage;//左边图片
@property(nonatomic,strong)UILabel * titleLabel;//标题
@property(nonatomic,strong)UIImageView * imagedan;//标题图标
@property(nonatomic,strong)UIImageView * woshouImage;//握手图标
@property(nonatomic,strong)UILabel * woshouLabel;//握手次数
@property(nonatomic,strong)UILabel * cishuLable;//次数
@property(nonatomic,strong)UIImageView * xingImage;//五角星
@property(nonatomic,strong)UIImageView * imagedw;//定位图标
@property(nonatomic,strong)UILabel * cityLabel;//定位城市

@end
@implementation YouZhiShangHuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    YouZhiShangHuCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[YouZhiShangHuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
     leftImage;//左边图片
     titleLabel;//标题
     imagedan;//标题图标
     woshouImage;//握手图标
     woshouLabel;//握手次数
     cishuLable;//次数
     xingImage;//五角星
     imagedw;//定位图标
     cityLabel;//定位城市
     */
    _leftImage=[UIImageView new];
    _titleLabel=[UILabel new];
    _imagedan=[UIImageView new];
    _imagedw=[UIImageView new];
    _cityLabel=[UILabel new];
    _cishuLable=[UILabel new];
    _xingImage=[UIImageView new];
    _woshouImage=[UIImageView new];
    _woshouLabel=[UILabel new];
    
    //属性
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines=0;
    _cityLabel.font=[UIFont systemFontOfSize:13];
    _cityLabel.alpha=.6;
    _cishuLable.font=[UIFont systemFontOfSize:13];
    _cishuLable.alpha=.6;
    _woshouLabel.font=[UIFont systemFontOfSize:13];
    _woshouLabel.alpha=.6;
    
    
    //赋值(固定值)
    _titleLabel.text=@"出售海泰500T注塑机";
    _leftImage.image=[UIImage imageNamed:@"xianhuo_pic1"];
    _imagedan.image=[UIImage imageNamed:@"xianhuo_dan"];
    _imagedw.image=[UIImage imageNamed:@"xianhuo_address"];
    _xingImage.image=[UIImage imageNamed:@"shanghu_shoucang"];
    _woshouImage.image=[UIImage imageNamed:@"shanghu_chengjiao"];
    
    _cityLabel.text=@"河北-石家庄";
    _cishuLable.text=@"1000次";
    _woshouLabel.text=@"100次";
    
    [self.contentView sd_addSubviews:@[_leftImage,_titleLabel,_imagedan,_imagedw,_woshouLabel,_woshouImage]];
    [self.contentView sd_addSubviews:@[_cityLabel,_cishuLable,_xingImage]];
    
    [self CreatFrame];
}
-(void)CreatFrame{
    //左边图片
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(209/2)
    .heightIs(156/2);
    //titleLabel
    _titleLabel.sd_layout
    .leftSpaceToView(_leftImage,15)
    .topSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-100];
    //担
    _imagedan.sd_layout
    .leftSpaceToView(_titleLabel,5)
    .topSpaceToView(self.contentView,10)
    .widthIs(37/2)
    .heightIs(37/2);
    //握手
    _woshouImage.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,15)
    .widthIs(28/2)
    .heightIs(21/2);
    //握手的次数
    _woshouLabel.sd_layout
    .leftSpaceToView(_woshouImage,5)
    .centerYEqualToView(_woshouImage)
    .heightIs(10);
    [_woshouLabel setSingleLineAutoResizeWithMaxWidth:130];
    //五角星
    _xingImage.sd_layout
    .leftSpaceToView(_woshouLabel,20)
    .centerYEqualToView(_woshouLabel)
    .widthIs(27/2)
    .heightIs(27/2);
    //五角星次数
    _cishuLable.sd_layout
    .leftSpaceToView(_xingImage,5)
    .heightIs(10)
    .centerYEqualToView(_xingImage);
    [_cishuLable setSingleLineAutoResizeWithMaxWidth:120];
    
    
    
    
    //定位的小图标
    _imagedw.sd_layout
    .topSpaceToView(_woshouImage,15)
    .leftEqualToView(_titleLabel)
    .widthIs(24/2)
    .heightIs(24/2);
    //定位的城市
    _cityLabel.sd_layout
    .leftSpaceToView(_imagedw,5)
    .centerYEqualToView(_imagedw)
    .heightIs(15);
    [_cityLabel setSingleLineAutoResizeWithMaxWidth:150];
   
    
    
    [self.contentView setupAutoHeightWithBottomView:_imagedw bottomMargin:10];
    
}
-(void)setModel:(HomeModel *)model{
    _model=model;
    _titleLabel.text=model.titleName;
    [_leftImage setImageWithURL:[NSURL URLWithString:model.imageview] placeholderImage:[UIImage imageNamed:@"xianhuo_pic1"]];
    _cityLabel.text=model.cityName;
    _cishuLable.text=model.taishuName;
    _woshouLabel.text=model.sheBeiName;
    NSLog(@"我看看a aaa");

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
