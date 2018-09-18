//
//  JW0905BaseWebController.h
//  Postre
//
//  Created by CoderLT on JW0905/5/22.
//  Copyright © JW0905年 CoderLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface JW0905BaseWebController : UIViewController <WKUIDelegate, WKNavigationDelegate>

+ (instancetype)jw0704JW0905KDManager:(NSString *)urlString
                     shareTitle:(NSString *)shareTitle
                       shareUrl:(NSString *)shareUrl;


@end
