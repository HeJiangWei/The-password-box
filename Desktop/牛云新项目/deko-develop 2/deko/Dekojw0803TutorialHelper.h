//
//  Dekojw0803TutorialHelper.h
//  deko
//
//  Created by Johan Halin on 9.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HarmonyCanvasSettings;

@interface Dekojw0803TutorialHelper : NSObject

@property (nonatomic, readonly) BOOL shouldShowTutorial;

- (void)showLeftArrowInView:(UIView *)view;
- (void)dismissLeftArrow;
- (void)showRightArrowInView:(UIView *)view;
- (void)dismissRightArrow;
- (void)showTapCirclesInView:(UIView *)view;
- (void)dismissTapCircles;
- (HarmonyCanvasSettings *)defaultSettings1;
- (HarmonyCanvasSettings *)defaultSettings2;

@end
