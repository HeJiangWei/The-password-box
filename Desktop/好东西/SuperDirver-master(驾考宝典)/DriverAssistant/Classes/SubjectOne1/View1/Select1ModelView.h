//
//  Select1ModelView.h
//  DriverAssistant
//
//  Created by C on JW 16/3/31.
//  Created by C on JW 118 rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectTouch)(UIButton *btn);
@interface Select1ModelView : UIView
- (Select1ModelView *)initWithFrame:(CGRect)frame andTouch:(SelectTouch)touch;
@end
