//
//  KDDefines.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0905/12/13.
//  Copyright © JW0905年 JW0905. All rights reserved.
//

#ifndef KDDefines_h
#define KDDefines_h


#ifndef kIsiPhoneX
#define kIsiPhoneX    ( fabs((double)[[UIScreen mainScreen] bounds].size.height - ( double )812 ) < DBL_EPSILON )
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH        (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#endif
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT       (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#endif
#ifndef STATUS_BAR_BAR_ADDING
#define STATUS_BAR_BAR_ADDING       (kIsiPhoneX ? 22 : 0)
#endif
#ifndef STATUS_BAR_HIGHT
#define STATUS_BAR_HIGHT    (kIsiPhoneX ? 44 : 20)
#endif
#ifndef NAVI_BAR_HIGHT
#define NAVI_BAR_HIGHT      (44)
#endif
#ifndef TAB_BAR_ADDING
#define TAB_BAR_ADDING       (kIsiPhoneX ? 34 : 0)
#endif
#ifndef TAB_BAR_HIGHT
#define TAB_BAR_HIGHT       (49 + TAB_BAR_ADDING)
#endif
#ifndef TOOL_BAR_HIGHT
#define TOOL_BAR_HIGHT       (44 + TAB_BAR_ADDING)
#endif
#ifndef NAVI_HIGHT
#define NAVI_HIGHT          (STATUS_BAR_HIGHT + NAVI_BAR_HIGHT)
#endif
/**
 *  打印相关
 */
#ifdef DEBUG

#ifndef NSLog
#define NSLog(...) printf("%s [%s:%d] %s\n", [[NSString stringWithFormat:@"%@", [[NSDate date] stringWithFormat:@"HH:mm:ss.SSS"]] UTF8String], [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String] , __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#endif
#else
#ifndef NSLog
# define NSLog(...)
#endif
#endif

#endif /* KDDefines_h */
