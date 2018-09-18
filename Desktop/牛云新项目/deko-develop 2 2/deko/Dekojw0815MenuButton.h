//
//  Dekojw0815MenuButton.h
//  deko
//
//  Created by Johan Halin on 24.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dekojw0815MenuButton;

@protocol Dekojw0815MenuButtonDelegate <NSObject>

@required
- (void)menuButton:(Dekojw0815MenuButton *)menuButton highlighted:(BOOL)highlighted;

@end

@interface Dekojw0815MenuButton : UIButton

@property (nonatomic, weak) NSObject<Dekojw0815MenuButtonDelegate> *delegate;

@end
