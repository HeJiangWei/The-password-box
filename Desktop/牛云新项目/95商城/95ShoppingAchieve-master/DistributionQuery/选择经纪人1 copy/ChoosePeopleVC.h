//
//  ChoosePeopleVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Basejw0803ViewController.h"

@interface ChoosePeopleVC : Basejw0803ViewController
@property(nonatomic,copy)void(^peopleIDBlock)(NSString*codeID);
@end
