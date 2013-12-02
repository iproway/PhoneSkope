

#import <UIKit/UIKit.h>
#import "PSFilterData.h"

typedef NS_ENUM(NSUInteger, CustomSwitchStatus)
{
    CustomSwitchStatusOn = 1,
    CustomSwitchStatusOff = 0
};

typedef NS_ENUM(NSUInteger, CustomSwitchArrange)
{
    CustomSwitchArrangeONLeftOFFRight = 0,
    CustomSwitchArrangeOFFLeftONRight = 1
};

@protocol CustomSwitchDelegate <NSObject>

-(void)customSwitchSetStatus:(CustomSwitchStatus)status atIndex:(int)index;
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
@property(nonatomic,assign) PSFilterData *data;
@end