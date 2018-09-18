//
//  JW0732BaseWebController.h
//  Postre
//
//  Created by CoderLT on JW0732/5/22.
//  Copyright © JW0732年 CoderLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface JW0732BaseWebController : UIViewController <WKUIDelegate, WKNavigationDelegate>

+ (instancetype)jw0704JW0732KDManager:(NSString *)urlString
                     shareTitle:(NSString *)shareTitle
                       shareUrl:(NSString *)shareUrl;


@end
