//
//  Answer1ViewController.h
//  DriverAssistant
//
//  Created by C on JW 16/3/29.
//  Created by C on JW 118 rights reserved.
//

#import <UIKit/UIKit.h>

@interface Answer1ViewController : UIViewController
@property (nonatomic, copy) NSString *myTitle;
@property (nonatomic, assign) NSInteger number;
@property(nonatomic,copy)NSString * subStrNumber;
//type=1 章节练习 type=2 顺序练习 type=3 随机练习 type=4 专项练习 type=5 模拟考试（全真） type = 6 模拟考试(先考未答) type = 7 我的错题 type =8 我的收藏
@property(nonatomic,assign)int type;
@end
