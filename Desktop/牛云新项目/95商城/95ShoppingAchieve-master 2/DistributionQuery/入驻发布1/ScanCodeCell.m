//
//  ScanCodeCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ScanCodeCell.h"
@interface ScanCodeCell()


@end
@implementation ScanCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    ScanCodeCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[ScanCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _textfield=[UITextField new];
    _yuYinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView sd_addSubviews:@[_nameLabel,_textfield,_yuYinBtn]];
    //属性
    _nameLabel.font=[UIFont systemFontOfSize:16];
    _nameLabel.alpha=.7;
    _textfield.font=[UIFont systemFontOfSize:15];
    [_yuYinBtn setImage:[UIImage imageNamed:@"fabu_yuyin"] forState:0];

    //name
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:120];
  
    //语音
    _yuYinBtn.hidden=YES;
    _yuYinBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(32/2)
    .heightIs(47/2);
    
    //textField
   // _textfield.backgroundColor=[UIColor yellowColor];
    _textfield.sd_layout
    .leftSpaceToView(_nameLabel,25)
    .rightSpaceToView(_yuYinBtn,15)
    .centerYEqualToView(_nameLabel)
    .heightIs(30);
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
