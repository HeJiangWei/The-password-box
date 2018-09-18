//
//  JW0914BaseWebController.h
//  Postre
//
//  Created by CoderLT on JW0914/5/22.
//  Copyright © JW0914年 CoderLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface JW0914BaseWebController : UIViewController <WKUIDelegate, WKNavigationDelegate>

+ (instancetype)jw0704JW0914KDManager:(NSString *)urlString
                     shareTitle:(NSString *)shareTitle
                       shareUrl:(NSString *)shareUrl;


@end
