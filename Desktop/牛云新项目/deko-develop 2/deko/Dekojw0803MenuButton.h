//
//  Dekojw0803MenuButton.h
//  deko
//
//  Created by Johan Halin on 24.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dekojw0803MenuButton;

@protocol Dekojw0803MenuButtonDelegate <NSObject>

@required
- (void)menuButton:(Dekojw0803MenuButton *)menuButton highlighted:(BOOL)highlighted;

@end

@interface Dekojw0803MenuButton : UIButton

@property (nonatomic, weak) NSObject<Dekojw0803MenuButtonDelegate> *delegate;

@end
