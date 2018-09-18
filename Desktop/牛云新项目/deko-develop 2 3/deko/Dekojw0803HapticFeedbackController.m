//
//  Dekojw0803HapticFeedbackController.m
//  deko
//
//  Created by Johan Halin on 17/11/2017.
//  Copyright © 2017 Aero Deko. All rights reserved.
//

#import "Dekojw0803HapticFeedbackController.h"

@interface Dekojw0803HapticFeedbackController ()
@property (nonatomic) UISelectionFeedbackGenerator *selectionChangedFeedbackGenerator;
@property (nonatomic) UINotificationFeedbackGenerator *selectionConfirmedFeedbackGenerator;
@end

@implementation Dekojw0803HapticFeedbackController

#pragma mark - NSObject

- (instancetype)init
{
    if ((self = [super init]))
    {
        if (@available(iOS 10, *))
        {
            _selectionChangedFeedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
            _selectionConfirmedFeedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
        }
    }
    
    return self;
}

#pragma mark - Public

- (void)selectionChanged
{
    [self.selectionChangedFeedbackGenerator selectionChanged];
}

- (void)selectionConfirmed
{
    [self.selectionConfirmedFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeSuccess];
}

@end
