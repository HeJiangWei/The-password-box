//

#import <UIKit/UIKit.h>

@interface Pagejw0918ControlView : UIView
+(Pagejw0918ControlView *)instance;
- (instancetype)initWithFrame:(CGRect)frame andImageList:(NSArray *)arr;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIPageControl *pageV;
@end



