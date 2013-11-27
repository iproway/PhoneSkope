

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"

@interface PSCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet CustomSwitch *switchBtn;

@end
