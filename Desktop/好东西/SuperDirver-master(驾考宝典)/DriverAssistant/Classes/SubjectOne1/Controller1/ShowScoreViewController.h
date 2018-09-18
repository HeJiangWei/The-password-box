//
//  ShowScoreViewController.h
//  DriverAssistant
//
//  Created by C on JW 16/4/3.
//  Created by C on JW 118 rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestScoreModel.h"
@interface ShowScoreViewController : UIViewController
@property (nonatomic, strong) TestScoreModel *testScoreModel;
- (instancetype)initWithTestScoreModel:(TestScoreModel *)testScoreModel;
@end
