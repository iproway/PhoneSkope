

#import <UIKit/UIKit.h>
#import "PSGeneral.h"

@interface PSCameraViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlFilter;
@property (weak, nonatomic) IBOutlet UITableView *tableViewFilter;

@end
