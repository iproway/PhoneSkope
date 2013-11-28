

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "PSFilterObject.h"

@interface PSCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet CustomSwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *checkBtn;

- (void)setDataForCustomCell:(PSFilterObject *)data;

@end
