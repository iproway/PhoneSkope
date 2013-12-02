

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "PSFilterData.h"

@protocol SwitchChangeDelegate <NSObject>

-(void)changeSwitchStatus:(BOOL)status atIndex:(int)index;

@end


@interface PSCustomCell : UITableViewCell <CustomSwitchDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet CustomSwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *checkBtn;
@property(nonatomic,retain) IBOutlet id<SwitchChangeDelegate> switchDelegate;
@property(nonatomic,assign) BOOL isChild;

- (void)setDataForCustomCell:(PSFilterData *)data;

@end
