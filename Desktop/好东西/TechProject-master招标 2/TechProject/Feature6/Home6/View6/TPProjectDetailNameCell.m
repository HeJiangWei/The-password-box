//
//  TPProjectDetailNameCell.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPProjectDetailNameCell.h"
#import "TPProjectDetailModel.h"

@interface TPProjectDetailNameCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation TPProjectDetailNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWith:(TPProjectInfoNameItem *)item{
    self.nameLabel.text = item.title;
}

@end
