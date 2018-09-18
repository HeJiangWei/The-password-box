//
//  GuanLiCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GuanLiCell.h"
@interface GuanLiCell()
@property(nonatomic,strong)UIImageView * leftImage;//左边的图片
@property(nonatomic,strong)UILabel * titleLable;//标题
@property(nonatomic,strong)UILabel * priceLabel;//价格
@property(nonatomic,strong)UILabel * cjLable;//成交次数
@property(nonatomic,strong)UIView * lineView;//灰色的线
@end
@implementation GuanLiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    GuanLiCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[GuanLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
     leftImage;//左边的图片
     titleLable;//标题
     priceLabel;//价格
     cjLable;//成交次数
     xiugaiBtn;//修改按钮
     tejiaBtn;//特价按钮
     lineView;//灰色的线
     
     */
    _leftImage=[UIImageView new];
    _titleLable=[UILabel new];
    _priceLabel=[UILabel new];
    _cjLable=[UILabel new];
    _xiugaiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _tejiaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _lineView=[UIView new];
    [self.contentView sd_addSubviews:@[_leftImage,_titleLable,_priceLabel]];
    [self.contentView sd_addSubviews:@[_cjLable,_xiugaiBtn,_tejiaBtn,_lineView]];
    //属性
    _titleLable.font=[UIFont systemFontOfSize:16];
    _titleLable.alpha=.8;
    _priceLabel.font=[UIFont systemFontOfSize:13];
    _priceLabel.textColor=[UIColor redColor];
    _priceLabel.alpha=.8;
    _cjLable.font=[UIFont systemFontOfSize:13];
    _cjLable.alpha=.6;
    _lineView.backgroundColor=COLOR;
    //_lineView.alpha=.6;
    //赋值
    _leftImage.image=[UIImage imageNamed:@"xianhuo_pic1"];
    _titleLable.text=@"山东馈线回收省威海市荣成有限公司";
    _priceLabel.text=@"8000元";
    _cjLable.text=@"查看100次";
    [_xiugaiBtn setImage:[UIImage imageNamed:@"guanli_xiugai"] forState:0];
    [_tejiaBtn setImage:[UIImage imageNamed:@"guanli_tejia"] forState:0];
    
    [self CreatFrame];
    
}


-(void)CreatFrame{
    //左边的图片
    _leftImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(209/2)
    .heightIs(156/2);
    //标题
    _titleLable.sd_layout
    .topEqualToView(_leftImage)
    .leftSpaceToView(_leftImage,10)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    //价格
    _priceLabel.sd_layout
    .leftEqualToView(_titleLable)
    .heightIs(20)
    .topSpaceToView(_titleLable,10);
    [_priceLabel setSingleLineAutoResizeWithMaxWidth:180];
    //成交次数
    _cjLable.sd_layout
    .leftSpaceToView(_priceLabel,20)
    .centerYEqualToView(_priceLabel)
    .topEqualToView(_priceLabel)
    .heightRatioToView(_priceLabel,1);
    //特价按钮
    _tejiaBtn.sd_layout
    .rightEqualToView(_titleLable)
    .topSpaceToView(_cjLable,10)
    .widthIs(110/2)
    .heightIs(50/2);
    //修改按钮
    _xiugaiBtn.sd_layout
    .rightSpaceToView(_tejiaBtn,10)
    .centerYEqualToView(_tejiaBtn)
    .heightIs(50/2)
    .widthIs(110/2);
    //线
    _lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1)
    .topSpaceToView(_xiugaiBtn,15);
    
    //创建刷新、下架、置顶、成交按钮

/*
 51 * 65 
 49 64
 50 65
 51 64
 */
    NSArray * arr =@[@"guanli_shuaxin",@"guanli_xiajia",@"guanli_zhiding",@"guanli_sure_now"];
    NSArray * arrClick =@[@"guanli_shuaxin_click",@"guanli_xiajia_click",@"guanli_zhiding_click",@"guanli_sure"];
    for (int i = 0; i<4; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:arr[i]] forState:0];
        [btn setImage:[UIImage imageNamed:arrClick[i]] forState:UIControlStateSelected];
        if (i==0) {
            _lastBtn=btn;
        }
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView sd_addSubviews:@[btn]];
        CGFloat k =ScreenWidth/4;
        CGFloat g =k;
        btn.sd_layout
        .leftSpaceToView(self.contentView,k*i)
        .topSpaceToView(_lineView,0)
        .widthIs(k)
        .heightIs(g/2);
    }
    
    
}
-(void)setModel:(GuanLiModel *)model
{
    _model=model;
    
    //_leftImage.image=[UIImage imageNamed:@"xianhuo_pic1"];
    [_leftImage setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"xianhuo_pic1"]];
    NSLog(@"输出一下地址%@",model.imageurl2);
    _titleLable.text=model.titleName;//@"山东馈线回收省威海市荣成有限公司";
    _priceLabel.text=[NSString stringWithFormat:@"%@元",model.priceName];//@"8000元";
    _cjLable.text=[NSString stringWithFormat:@"查看%@次",model.chaKan];//@"查看100次";
    
    
}
-(void)btnClick:(UIButton*)btn{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(btn,self.indexPath);
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=5;
    frame.size.height-=5;
    [super setFrame:frame];
}
@end
