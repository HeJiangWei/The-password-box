//
//  Dekojw0803ViewController.h
//  deko
//
//  Created by Johan Halin on 26.11.2012.
//  Copyright (c) 2018 Aero Deko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class DekoIAPManager;
@class Dekojw0803ShareHelper;
@class DekoSceneManager;
@class HarmonySettingGenerator;
@class DekoGalleryViewController;
@class DekoIAPViewController;
@class Harmonyjw0803ColorGenerator;

@interface Dekojw0803ViewController : UIViewController

@property (nonatomic) DekoIAPManager *purchaseManager;
@property (nonatomic) Dekojw0803ShareHelper *shareHelper;
@property (nonatomic) DekoSceneManager *sceneManager;
@property (nonatomic) DekoGalleryViewController *galleryViewController;
@property (nonatomic) HarmonySettingGenerator *settingGenerator;
@property (nonatomic) DekoIAPViewController *iapViewController;
@property (nonatomic) Harmonyjw0803ColorGenerator *colorGenerator;

@end
