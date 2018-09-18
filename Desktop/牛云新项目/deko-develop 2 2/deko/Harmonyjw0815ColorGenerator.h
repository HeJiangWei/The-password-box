//
//  Harmonyjw0815ColorGenerator.h
//  harmonyvisualengine
//
//  Created by Johan Halin on 9.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HarmonyCanvasSettings.h"

@interface Harmonyjw0815ColorGenerator : NSObject

- (UIColor *)colorWithStartingHue:(CGFloat)hue
						colorType:(HarmonyColorType)colorType
				   brightnessType:(HarmonyColorBrightnessType)brightnessType
				   saturationType:(HarmonyColorSaturationType)saturationType
					   mixingType:(HarmonyMixingType)mixingType
					   background:(BOOL)background;

@end
