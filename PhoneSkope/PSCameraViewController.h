

#import <UIKit/UIKit.h>
#import "PSGeneral.h"
#import "PSFilterManager.h"

@interface PSCameraViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlFilter;
@property (weak, nonatomic) IBOutlet UITableView *tableViewFilter;
@property (weak, nonatomic) IBOutlet UIView* flashMenu;
@property (weak, nonatomic) IBOutlet UIButton* zoomBtn;
@property (weak, nonatomic) IBOutlet UIButton* optionBtn;
@property (weak, nonatomic) IBOutlet UIButton* flashBtn;
@property (weak, nonatomic) IBOutlet UISlider* sliderBar;

@property (weak, nonatomic) IBOutlet UIButton* flAutoBtn;
@property (weak, nonatomic) IBOutlet UIButton* flAlwayBtn;
@property (weak, nonatomic) IBOutlet UIButton* flNoneBtn;
@property (weak, nonatomic) IBOutlet UIButton* flSoundBtn;

@end
