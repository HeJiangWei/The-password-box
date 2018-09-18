//
//  MyselfPublicCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyselfPublicCell.h"

@implementation MyselfPublicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyselfPublicCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyselfPublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _nameLabel=[UILabel new];
    _textField=[UITextField new];
    _yuYinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView sd_addSubviews:@[_nameLabel,_textField,_yuYinBtn]];
    //属性
    _nameLabel.alpha=.7;
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _textField.alpha=.8;
    _textField.font=[UIFont systemFontOfSize:16];
    [_yuYinBtn setImage:[UIImage imageNamed:@"fabu_yuyin"] forState:0];
    
    _yuYinBtn.hidden=YES;
    _yuYinBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(32/2)
    .heightIs(47/2);
    
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(30);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _textField.sd_layout
    .leftSpaceToView(_nameLabel,25)
    .centerYEqualToView(_nameLabel)
    .heightIs(30)
    .widthIs(150);
    
   
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
