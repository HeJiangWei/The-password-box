//
//  HarmonySettingGenerator.h
//  deko
//
//  Created by Johan Halin on 30.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger DekoMaximumSettingSteps = 6;

@class HarmonyCanvasSettings;
@class Harmonyjw0803ColorGenerator;

@interface HarmonySettingGenerator : NSObject

@property (nonatomic) Harmonyjw0803ColorGenerator *colorGenerator;

- (HarmonyCanvasSettings *)generateNewSettings;
- (HarmonyCanvasSettings *)generateNewSettingsBasedOnSettings:(HarmonyCanvasSettings *)settings step:(NSInteger)step;

@end
