//
//  Tools.m
//  DriverAssistant
//
//  Created by C on JW 16/3/29.
//  Created by C on JW 118 rights reserved.
//

#import "Tools.h"

@implementation Tools
+ (NSArray *)getAnswerWithString:(NSString *)str
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i = 0; i < 4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}
+ (CGSize)getSizeWithString:(NSString *)str withFont:(UIFont *)font withSize:(CGSize)size
{
    CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    return newSize;
}
@end
