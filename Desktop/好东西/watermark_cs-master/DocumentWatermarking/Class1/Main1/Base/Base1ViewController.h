//
//  Base1ViewController.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Base1ViewController : UIViewController

@property(nonatomic,copy)void(^backCall)(void);

@property(nonatomic,copy)NSString *titleString;

-(void)rightButtonImage:(UIImage*)image RightButtonTitle:(NSString*)rightBtnTitle rightButtonTarget:(id)target rightButtonAction:(SEL)action;


@end
