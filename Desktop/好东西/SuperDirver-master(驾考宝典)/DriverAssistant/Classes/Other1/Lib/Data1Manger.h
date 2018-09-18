//
//  Data1Manger.h
//  DriverAssistant
//
//  Created by C on JW 16/3/28.
//  Created by C on JW 118 rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    chapter,    //章节练习数据
    answer,     //答题数据
    subChapter//专项练习
}DataType;
@interface Data1Manger : NSObject
+ (NSArray *)getData:(DataType)type;
@end
