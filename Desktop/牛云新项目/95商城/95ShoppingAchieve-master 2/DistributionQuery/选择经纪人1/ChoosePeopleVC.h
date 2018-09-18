//
//  ChoosePeopleVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface ChoosePeopleVC : BaseViewController
@property(nonatomic,copy)void(^peopleIDBlock)(NSString*codeID);
@end
