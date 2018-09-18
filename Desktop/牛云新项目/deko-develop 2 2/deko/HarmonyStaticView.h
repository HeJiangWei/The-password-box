//
//  HarmonyStaticView.h
//  harmonyvisualengine
//
//  Created by Johan Halin on 8.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Harmonyjw0815ColorGenerator;
@class HarmonyCanvasSettings;

@interface HarmonyStaticView : UIView

@property (nonatomic) Harmonyjw0815ColorGenerator *colorGenerator;

- (void)updateCanvasWithSettings:(HarmonyCanvasSettings *)settings;

@end
