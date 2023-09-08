
#import "Drawzb.h"
#import <mach-o/dyld.h>
#import <mach/mach.h>
#import <dlfcn.h>
#import <stdio.h>
#import <string>

#import "Floating/JFCommon.h"

using namespace std;

#pragma mark

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[IFuckYou getInstance] entry];
    });
}

__attribute__((constructor)) static void initialize()
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDrop);
}

#pragma mark
@interface IFuckYou ()

@property (nonatomic, strong) NSTimer *dataTimer;
@property (nonatomic, strong) NSTimer *actionTimer;

@end

@implementation IFuckYou

UIView* NoRecView;
UITextField *ffield = [[UITextField alloc] init];
static IFuckYou *instance = nil;

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

+ (IFuckYou *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (id)allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
+ (UITextField *)getNoRecView
{
    return ffield;
}

#pragma mark
- (void)entry
{
    if (!self.floatingMenuView.superview) {

        /* sets up the secure textfield view which hides the icon from the screen */
        NoRecView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        [NoRecView setBackgroundColor:[UIColor clearColor]];
        [NoRecView setUserInteractionEnabled:YES];
        ffield.secureTextEntry = true;
        [NoRecView addSubview:ffield];
        NoRecView = ffield.layer.sublayers.firstObject.delegate;
        [[UIApplication sharedApplication].keyWindow addSubview:NoRecView];


        /* adds a clear image which the user can interact with, while the image is displayed on the 
        view which is hidden from recordings, so it acts as if it were a normal menu icon, while still being hidden
        the position is updated 20 times a second */
        self.floatingMenuView.iconImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:@"" options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        
        /* to change the main icon image, go into Floaintg / JFFloatingMenuView.mm and paste your desired image as a base64 string */
        [[UIApplication sharedApplication].keyWindow addSubview:self.overlayView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.floatingMenuView];
        [NoRecView addSubview:self.floatingMenuViewTwo];
    }
    [self startFuckYou];
}

- (void)startFuckYou
{
    [self cancelTimer];
    self.dataTimer = [NSTimer timerWithTimeInterval:1.0f/20 target:self selector:@selector(UpdateIcon) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.dataTimer forMode:NSRunLoopCommonModes];}

- (void)cancelTimer
{
    if (self.dataTimer) {
        [self.dataTimer invalidate];
        self.dataTimer = nil;
    }
}
#pragma mark
- (void)UpdateIcon
{
     self.floatingMenuViewTwo.frame = self.floatingMenuView.frame;
     [NoRecView setNeedsDisplay];
     return;
}

#pragma mark   
- (JFFloatingMenuView *)floatingMenuView
{
    if (!_floatingMenuView) {
        _floatingMenuView = [[JFFloatingMenuView alloc] initWithFrame:CGRectMake(489, 58, 45, 45)];
    }
    return _floatingMenuView;
}
- (JFFloatingMenuView *)floatingMenuViewTwo
{
    if (!_floatingMenuViewTwo) {
        _floatingMenuViewTwo = [[JFFloatingMenuView alloc] initWithFrame:CGRectMake(489, 58, 45, 45)];
    }
    return _floatingMenuViewTwo;
} //getinstance

- (JFOverlayView *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[JFOverlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _overlayView;
}

@end
