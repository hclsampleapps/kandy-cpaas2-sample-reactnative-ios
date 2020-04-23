#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>
@import CPaaSSDK;


@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>

@property (nonatomic, strong) UIWindow *window;
@property(strong, nonatomic) CPaaS *cpassObj;


@end
