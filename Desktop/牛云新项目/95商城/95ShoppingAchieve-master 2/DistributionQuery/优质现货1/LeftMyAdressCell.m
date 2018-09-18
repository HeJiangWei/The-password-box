//
//  LeftMyAdressCell.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LeftMyAdressCell.h"
@interface LeftMyAdressCell()
@property(nonatomic,strong)UILabel * nameLabel;
@end
@implementation LeftMyAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString * ID =@"left";
    LeftMyAdressCell * cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[LeftMyAdressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * bg =[[UIImageView alloc]init];
        bg.image=[UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView=bg;
        
        UIImageView * selectbg =[UIImageView new];
        selectbg.image=[UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView=selectbg;
        
        _nameLabel=[UILabel new];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textAlignment=1;
        [self.contentView sd_addSubviews:@[_nameLabel]];
        _nameLabel.sd_layout
        .leftSpaceToView(self.contentView,45)
        .rightSpaceToView(self.contentView,15)
        .heightIs(20)
        .centerYEqualToView(self.contentView);
    }
    
    
    return self;
}
-(void)setName:(NSString *)name
{
    _name=name;
    _nameLabel.text=name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
