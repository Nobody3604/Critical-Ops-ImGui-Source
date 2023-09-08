

#import <UIKit/UIKit.h>
#import "Drawst.h"

//@class JFPlayer, JFProps, JFPlayerPool, JFPropsPool;

@interface IFuckYou : NSObject

@property (nonatomic, strong) JFOverlayView *overlayView;
@property (nonatomic, strong) JFFloatingMenuView *floatingMenuView;
@property (nonatomic, strong) JFFloatingMenuView *floatingMenuViewTwo;

+ (IFuckYou *)getInstance;
+ (UITextField *)getNoRecView;

- (void)entry;
//QQ654153159
- (void)cancelTimer;

@end
