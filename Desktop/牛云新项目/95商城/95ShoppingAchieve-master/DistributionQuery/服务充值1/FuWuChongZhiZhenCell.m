//
//  FuWuChongZhiZhenCell.m
//  DistributionQuery
//
//  Created by Macx on 16/12/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuWuChongZhiZhenCell.h"
@interface FuWuChongZhiZhenCell()
@property(nonatomic,strong)UIImageView * imageview;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * contentLabel;

@end
@implementation FuWuChongZhiZhenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    FuWuChongZhiZhenCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[FuWuChongZhiZhenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _imageview=[UIImageView new];
    _titleLabel=[UILabel new];
    _contentLabel=[UILabel new];
    _chongZhiBtn=[UIButton new];
    [self.contentView sd_addSubviews:@[_imageview,_titleLabel]];
    [self.contentView sd_addSubviews:@[_contentLabel,_chongZhiBtn]];
    
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.alpha=.8;
    _contentLabel.font=[UIFont systemFontOfSize:14];
    _contentLabel.alpha=.6;
    _contentLabel.numberOfLines=0;
    _chongZhiBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _chongZhiBtn.alpha=.6;
    //坐标
    _imageview.sd_layout
    .leftSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(124/2)
    .heightIs(124/2);
    //标题
//    _titleLabel.backgroundColor=[UIColor redColor];
//    _contentLabel.backgroundColor=[UIColor yellowColor];
//    _chongZhiBtn.backgroundColor=[UIColor greenColor];
    
    _titleLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .leftSpaceToView(_imageview,20)
    .rightSpaceToView(self.contentView,15)
    .heightIs(20);
    //内容
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,5)
    .rightSpaceToView(self.contentView,30)
    .autoHeightRatio(0);
   
    //立即充值
    _chongZhiBtn.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_contentLabel,10)
    .widthIs(119/2)
    .heightIs(25/2);
    
}
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
    _imageview.image=[UIImage imageNamed:[dic objectForKey:@"image1"]];
    _titleLabel.text=[dic objectForKey:@"title1"];
    NSLog(@"数出%@",[dic objectForKey:@"title1"]);
    _contentLabel.text=[dic objectForKey:@"content1"];
    [_chongZhiBtn setImage:[UIImage imageNamed:[dic objectForKey:@"btn1"]] forState:0];
}






-(void)setFrame:(CGRect)frame
{
    frame.origin.y+=10;
    frame.size.height-=10;
    frame.origin.x+=10;
    frame.size.width-=20;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
