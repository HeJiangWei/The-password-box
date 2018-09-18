//
//  RegistVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistVC : BaseViewController
@property(nonatomic,copy)void(^userNamePswBlock)(NSString*user,NSString*psw);

@end
