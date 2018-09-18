//
//  JCPageSlide4Bar.h
//  JCPageControllerDemo
//
//  Created by 郑嘉成 on 2017/2/10.
//  Copyright © 2017年 ZhengJiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCPageContoller.h"
@class JCPageSlide4Bar;

@protocol JCPageSlide4BarDelegate <NSObject>

@optional
- (void)pageSlideBar:(JCPageSlide4Bar *)pageSlideBar didSelectBarAtIndex:(NSInteger)index;
@end

@interface JCPageSlide4Bar : UIView

@property (nonatomic, assign) JCSlideBarLineAnimationType lineAinimationType;
@property (nonatomic, weak) id<JCPageContollerDataSource> dataSource;
@property (nonatomic, weak) id<JCPageSlide4BarDelegate> delegate;
@property (nonatomic, weak) JCPageContoller *controller;
@property (nonatomic) BOOL scaleSelectedBar;

- (void)selectTabAtIndex:(NSInteger)index;

- (void)moveBottomLineToIndex:(NSInteger)index;

- (void)stretchBottomLineFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

- (void)scaleTitleFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

- (void)reloadData;

@end
