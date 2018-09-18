//
//  Dekojw0815ShareHelper.h
//  deko
//
//  Created by Johan Halin on 4.12.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DekoMenuView.h"

@class Dekojw0815ShareHelper;
@class DekoLocalizationManager;

@protocol Dekojw0815ShareHelperDelegate <NSObject>

@required
- (void)shareHelper:(Dekojw0815ShareHelper *)shareHelper wantsToShowViewController:(UIViewController *)viewController;
- (void)shareHelper:(Dekojw0815ShareHelper *)shareHelper savedImageWithError:(NSError *)error;

@end

@interface Dekojw0815ShareHelper : NSObject

@property (nonatomic, weak) NSObject<Dekojw0815ShareHelperDelegate> *delegate;
@property (nonatomic) DekoLocalizationManager *localizationManager;

- (void)shareImage:(UIImage *)image shareType:(DekoShareType)shareType proPurchased:(BOOL)proPurchased;

@end
