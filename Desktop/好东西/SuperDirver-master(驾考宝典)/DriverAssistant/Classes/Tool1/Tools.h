//
//  Tools.h
//  DriverAssistant
//
//  Created by C on JW 16/3/29.
//  Created by C on JW 118 rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
+ (NSArray *)getAnswerWithString:(NSString *)str;
+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size;
@end
