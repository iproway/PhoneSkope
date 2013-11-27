

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomSwitchStatus)
{
    CustomSwitchStatusOn = 0,
    CustomSwitchStatusOff = 1
};

typedef NS_ENUM(NSUInteger, CustomSwitchArrange)
{
    CustomSwitchArrangeONLeftOFFRight = 0,
    CustomSwitchArrangeOFFLeftONRight = 1
};

@protocol CustomSwitchDelegate <NSObject>

-(void)customSwitchSetStatus:(CustomSwitchStatus)status;
@end

@interface CustomSwitch : UIControl
{
    UIImage *_onImage;
    UIImage *_offImage;
    id<CustomSwitchDelegate> _delegate;
    CustomSwitchArrange _arrange;
    
}
@property(nonatomic,retain) UIImage *onImage;
@property(nonatomic,retain) UIImage *offImage;
@property(nonatomic,retain) IBOutlet id<CustomSwitchDelegate> delegate;
@property(nonatomic) CustomSwitchArrange arrange;
@property(nonatomic) CustomSwitchStatus status;
@end