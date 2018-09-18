//
//  PopView.h
//  ButtonPopMen
//
//  Created by Macx on 16/7/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView
@property(nonatomic,copy)void(^btnNameBlock)(NSString*name);
@property(nonatomic,retain)NSArray * dataArray;
-(id)initWithFrame:(CGRect)frame;
-(void)show;
-(void)hide;
@end
