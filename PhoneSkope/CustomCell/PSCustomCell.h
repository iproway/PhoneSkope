

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "PSFilterObject.h"

@protocol SwitchChangeDelegate <NSObject>

-(void)changeSwitchStatus:(BOOL)status;

@end


@interface PSCustomCell : UITableViewCell <CustomSwitchDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet CustomSwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *checkBtn;
@property(nonatomic,retain) IBOutlet id<SwitchChangeDelegate> switchDelegate;

- (void)setDataForCustomCell:(PSFilterObject *)data;

@end
