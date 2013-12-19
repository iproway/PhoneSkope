

#import <UIKit/UIKit.h>
#import "PSGeneral.h"
#import "PSFilterManager.h"
#import "PSCustomCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TVCalibratedSlider.h"
#import <GPUImage/GPUImage.h>

@interface PSCameraViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SwitchChangeDelegate, GPUImageVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIButton *thumbPhotoImage;
@property (weak, nonatomic) IBOutlet UIButton *cameraChangeImage;
@property (strong, nonatomic) IBOutlet UIView *captureView;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBarImage;
@property (weak, nonatomic) IBOutlet UIImageView *rectImage;

@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UILabel *filterTitle;
@property (weak, nonatomic) IBOutlet UILabel *filterValue;
@property (weak, nonatomic) IBOutlet TVCalibratedSlider *scaledSlider;

@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlFilter;
@property (weak, nonatomic) IBOutlet UIButton *captureBtn;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *timmerLable;
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
- (IBAction)sliderValueChanged:(id)sender;

@property(nonatomic, retain) CIDetector*faceDetector;

- (IBAction)openPhotoGallery:(id)sender;
- (IBAction)captureAction:(id)sender;
- (IBAction)closeFilterChildren:(id)sender;
- (IBAction)changeVideoMode:(id)sender;

@end