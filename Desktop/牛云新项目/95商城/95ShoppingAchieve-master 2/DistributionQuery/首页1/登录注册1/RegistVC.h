//
//  RegistVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Basejw0803ViewController.h"

@interface RegistVC : Basejw0803ViewController
@property(nonatomic,copy)void(^userNamePswBlock)(NSString*user,NSString*psw);

@end
