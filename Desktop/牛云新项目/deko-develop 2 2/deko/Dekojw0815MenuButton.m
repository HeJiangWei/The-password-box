//
//  Dekojw0815MenuButton.m
//  deko
//
//  Created by Johan Halin on 24.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import "Dekojw0815MenuButton.h"

@implementation Dekojw0815MenuButton

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	[self.delegate menuButton:self highlighted:highlighted];
}

@end
