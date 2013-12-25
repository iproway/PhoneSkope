

#import <UIKit/UIKit.h>
#import "PSCameraViewController.h"

#define ApplicationDelegate ((PSAppDelegate *)[UIApplication sharedApplication].delegate)

@interface PSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *homeNavigationController;

@end
