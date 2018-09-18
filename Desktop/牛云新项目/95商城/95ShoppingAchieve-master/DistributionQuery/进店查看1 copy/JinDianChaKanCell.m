//
//  JinDianChaKanCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "JinDianChaKanCell.h"
@interface JinDianChaKanCell ()
@property(nonatomic,strong)UIImageView * leftImage;//左边图片
@property(nonatomic,strong)UILabel * titleLabel;//标题
@property(nonatomic,strong)UIImageView * imagedan;//标题图标
@property(nonatomic,strong)UIImageView * imagedw;//定位图标
@property(nonatomic,strong)UILabel * cityLabel;//定位城市
@property(nonatomic,strong)UILabel * taishuLabel;//台数
@property(nonatomic,strong)UILabel * priceLabel;//价格

@end
@implementation JinDianChaKanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    JinDianChaKanCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[JinDianChaKanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
     imagedw;//定位图标
     cityLabel;//定位城市
     taishuLabel;//台数
     priceLabel;//价格
     chaKanBtn;//立即查看
     */
    _leftImage=[UIImageView new];
    _titleLabel=[UILabel new];
    _imagedan=[UIImageView new];
    _imagedw=[UIImageView new];
    _cityLabel=[UILabel new];
    _taishuLabel=[UILabel new];
    _priceLabel=[UILabel new];
    _chaKanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //属性
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines=0;
    _cityLabel.font=[UIFont systemFontOfSize:13];
    _cityLabel.alpha=.6;
    _taishuLabel.font=[UIFont systemFontOfSize:13];
    _taishuLabel.alpha=.6;
    _priceLabel.font=[UIFont systemFontOfSize:15];
    _priceLabel.textColor=[UIColor redColor];
    //赋值(固定值)
    _titleLabel.text=@"出售海泰500T注塑机";
    _leftImage.image=[UIImage imageNamed:@"xianhuo_pic1"];
    _imagedan.image=[UIImage imageNamed:@"xianhuo_dan"];
    _imagedw.image=[UIImage imageNamed:@"xianhuo_address"];
    _cityLabel.text=@"河北-石家庄";
    _taishuLabel.text=@"10台";
    _priceLabel.text=@"8000元";
    [_chaKanBtn setBackgroundImage:[UIImage imageNamed:@"xianhuo_chakan"] forState:0];
    
    [self.contentView sd_addSubviews:@[_leftImage,_titleLabel,_imagedan,_imagedw]];
    [self.contentView sd_addSubviews:@[_cityLabel,_taishuLabel,_priceLabel,_chaKanBtn]];
    
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
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth-150];
    //担
    _imagedan.sd_layout
    .leftSpaceToView(_titleLabel,5)
    .topSpaceToView(self.contentView,10)
    .widthIs(37/2)
    .heightIs(37/2);
    //定位的小图标
    _imagedw.sd_layout
    .topSpaceToView(_titleLabel,10)
    .leftEqualToView(_titleLabel)
    .widthIs(24/2)
    .heightIs(24/2);
    //定位的城市
    _cityLabel.sd_layout
    .leftSpaceToView(_imagedw,5)
    .centerYEqualToView(_imagedw)
    .heightIs(15);
    [_cityLabel setSingleLineAutoResizeWithMaxWidth:150];
    //几台
    _taishuLabel.sd_layout
    .leftSpaceToView(_cityLabel,10)
    .centerYEqualToView(_cityLabel)
    .heightRatioToView(_cityLabel,1);
    [_taishuLabel setSingleLineAutoResizeWithMaxWidth:150];
    //价格
    _priceLabel.sd_layout
    .leftEqualToView(_imagedw)
    .heightIs(20)
    .topSpaceToView(_imagedw,10);
    [_priceLabel setSingleLineAutoResizeWithMaxWidth:150];
    //立即查看
    _chaKanBtn.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(_priceLabel)
    .widthIs(117/2)
    .heightIs(43/2);
    
    
    [self setupAutoHeightWithBottomView:_chaKanBtn bottomMargin:10];
    
}

-(void)setModel:(JinDianModel *)model{
    _model=model;
//    _titleLabel.text=@"出售海泰500T注塑机";
//    _leftImage
//    _cityLabel.text=@"河北-石家庄";
//    _taishuLabel.text=@"10台";
//    _priceLabel.text=@"8000元";
    
    _titleLabel.text=model.titleName;
    [_leftImage setImageWithURL:[NSURL URLWithString:model.imageview] placeholderImage:[UIImage imageNamed:@"xianhuo_pic1"]];
    _cityLabel.text=model.diquName;
    _taishuLabel.text=[NSString stringWithFormat:@"%@台",model.taishuName];
    
    _priceLabel.text=[NSString stringWithFormat:@"%@台",model.priceName];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
