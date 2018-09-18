//
//  Dekojw0803LogoView.h
//  deko
//
//  Created by Johan Halin on 26.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dekojw0803LogoView : UIView

- (void)setup;
- (void)animateLogoWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;

@end
