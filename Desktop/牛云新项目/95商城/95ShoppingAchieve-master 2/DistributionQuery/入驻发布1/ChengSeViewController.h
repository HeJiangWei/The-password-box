//
//  ChengSeViewController.h
//  DistributionQuery
//
//  Created by Macx on 16/12/2.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface ChengSeViewController : BaseViewController
@property(nonatomic,copy)void(^chengSeBlock)(NSString*chengse,NSString*chengSeCode);
@end
