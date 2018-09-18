//
//  Dekojw0803ShareHelper.h
//  deko
//
//  Created by Johan Halin on 4.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DekoMenuView.h"

@class Dekojw0803ShareHelper;
@class DekoLocalizationManager;

@protocol Dekojw0803ShareHelperDelegate <NSObject>

@required
- (void)shareHelper:(Dekojw0803ShareHelper *)shareHelper wantsToShowViewController:(UIViewController *)viewController;
- (void)shareHelper:(Dekojw0803ShareHelper *)shareHelper savedImageWithError:(NSError *)error;

@end

@interface Dekojw0803ShareHelper : NSObject

@property (nonatomic, weak) NSObject<Dekojw0803ShareHelperDelegate> *delegate;
@property (nonatomic) DekoLocalizationManager *localizationManager;

- (void)shareImage:(UIImage *)image shareType:(DekoShareType)shareType proPurchased:(BOOL)proPurchased;

@end
