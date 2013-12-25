

#import "PSCameraViewController.h"
#import "PSCustomCell.h"
#import <CoreLocation/CoreLocation.h>
#import "GalleryViewController.h"

typedef enum
{
    TypeDateTime = 0,
    TypeClockTime = 1
} TypeSaveFile;

typedef enum
{
    Type3GP = 0,
    TypeMPEG4 = 1
} VideoFileType;

#define kPollingInterval 0.1
#define TABLE_HEIGHT 36.0f

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface PSCameraViewController ()
{
    CLLocationManager *locationManager;
    NSString *_currentLocation;
    CLGeocoder *_geocoder;

    int max_ITEM_COUNT;
    int max_ITEM_COUNT_LANDCAPT;
    int maximumItemCount;
    FilterMode _currentSessionFilter;
    FilterMode _backupFilter;
    
    NSArray* _arrayCamera;
    NSArray* _arrayPhoto;
    NSArray* _arrayOther;
    NSArray* _arrayVideo;
    
    NSArray* _arrayFilterChildElement;
    
    NSArray* _backupArray;
    
    PSFilterData* _currentParentFilterObject;
    PSFilterData* _currentChildFilterObject;
    PSFilterManager* _filterManager;
    
    BOOL _isChildFilter;
    
    GPUImageVideoCamera* _cameraFilter;
    GPUImageStillCamera* _stillCameraFilter;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageFilterGroup *_filterGroup;
    GPUImageOutput<GPUImageInput> *_currentFilterInput, *_firstFilterInput;
    GPUImageView *_filteredView;
    GPUImageView *_filterVideoView;
    NSString *pathToMovie;
    
    GPUImageFilter *_filterVideo;
    
    NSMutableArray *_currentFilterArray;
    
    FlashLightType _flashLight;
    AVCaptureDevice *flashLight;
    BOOL _isNoFlashLight;
    BOOL faceThinking;
    UIView *faceView;
    int _indexTest;
    GPUImageMotionDetector *filterMotionDetector;
    GPUImageCropFilter *transformFilter;
    
    GPUImageUIElement *_uiTimeElementInput, *_uiGPSElementInput;
    GPUImageAlphaBlendFilter *blendTimeFilter, *blendGPSFilter;
    
    BOOL _isVideoStyle;
    float _photoJPEGQuanlity;
    
    ALAssetsLibrary *_assetsLibrary;
    
    BOOL _isAddTimeLable;
    BOOL _isAddGPSLable;
    BOOL _idHDRPresetHigh;
    BOOL _isStabilizer;
    BOOL _isAutoRotationVideo;
    
    NSString* _photoResolution;
    UILabel *_timeLabel;
    UILabel *_gPSLabel;
    
    NSTimer *pollingTimer;
    NSDateFormatter *dateFormatter;
    CFTimeInterval _ticks;
    GPUImageMovieWriter *movieWriter;
    TypeSaveFile _saveFileType;
    VideoFileType _videoFileType;
    
    GPUImageOutput<GPUImageInput> *_currentVideoFilterAdded;
    
    int _previewTime;
}

@end

@implementation PSCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark - Init UIView when start

- (void)initUIButtonControll;
{
    CGAffineTransform sliderRotation = CGAffineTransformIdentity;
    sliderRotation = CGAffineTransformRotate(sliderRotation, (-M_PI / 2));
    self.sliderBar.transform = sliderRotation;
    [self.sliderBar setValue:0];
    self.sliderBar.minimumValue = 0;
    self.sliderBar.maximumValue = 10.0f;
    [self.sliderBar addTarget:self action:@selector(sliderValueChanged:)
                        forControlEvents:UIControlEventValueChanged];

    
//    transformFilter = [[GPUImageCropFilter alloc] init];
//    [(GPUImageCropFilter *)transformFilter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
    
    [self.optionBtn setImage:[UIImage imageNamed:@"optionbutton_highlight.png"] forState:UIControlStateSelected];
    [self.optionBtn setImage:[UIImage imageNamed:@"optionButton.png"] forState:UIControlStateNormal];
    [self.zoomBtn setImage:[UIImage imageNamed:@"zoom_normal.png"] forState:UIControlStateNormal];
    [self.zoomBtn setImage:[UIImage imageNamed:@"zoom_selected.png"] forState:UIControlStateSelected];
    
    // Flash button
    [self.flashBtn setBackgroundImage:[[UIImage imageNamed:@"bg-flash-btn-no-select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateNormal];
    [self.flashBtn setBackgroundImage:[[UIImage imageNamed:@"bg-flash-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateHighlighted];
    [self.flashBtn setBackgroundImage:[[UIImage imageNamed:@"bg-flash-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateSelected];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash.png"]
                   forState:UIControlStateNormal];
    
    // Flash Auto button
    [self.flAutoBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-no-select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateNormal];
    [self.flAutoBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateHighlighted];
    [self.flAutoBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                             forState:UIControlStateSelected];
    
    [self.flAutoBtn setImage:[UIImage imageNamed:@"icon-flash-auto.png"]
                   forState:UIControlStateNormal];
    [self.flAutoBtn setImage:[UIImage imageNamed:@"icon-flash-auto-focus.png"]
                    forState:UIControlStateSelected];
    
    // Flash alway button
    [self.flAlwayBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-no-select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateNormal];
    [self.flAlwayBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateHighlighted];
    [self.flAlwayBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateSelected];
    
    [self.flAlwayBtn setImage:[UIImage imageNamed:@"icon-flash.png"]
                     forState:UIControlStateNormal];
    [self.flAlwayBtn setImage:[UIImage imageNamed:@"icon-flash-focus.png"]
                     forState:UIControlStateSelected];
    
    // Flash none button
    [self.flNoneBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-no-select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                               forState:UIControlStateNormal];
    [self.flNoneBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                               forState:UIControlStateHighlighted];
    [self.flNoneBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                               forState:UIControlStateSelected];
    
    [self.flNoneBtn setImage:[UIImage imageNamed:@"icon-flash-off.png"]
                     forState:UIControlStateNormal];
    [self.flNoneBtn setImage:[UIImage imageNamed:@"icon-flash-off-focus.png"]
                    forState:UIControlStateSelected];
    
    // Flash sound button
    [self.flSoundBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-no-select.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateNormal];
    [self.flSoundBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateHighlighted];
    [self.flSoundBtn setBackgroundImage:[[UIImage imageNamed:@"bg-btn-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)]
                              forState:UIControlStateSelected];
    
    [self.flSoundBtn setImage:[UIImage imageNamed:@"icon-flash-sound.png"]
                    forState:UIControlStateNormal];
    [self.flSoundBtn setImage:[UIImage imageNamed:@"icon-flash-sound-focus.png"]
                     forState:UIControlStateSelected];
    
    // Init timelable and gps lable ovelay on picture image
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 240.0f, 320.0f)];
    _timeLabel.font = [UIFont systemFontOfSize:14.0f];
    _timeLabel.text = @"";
    _timeLabel.textAlignment = UITextAlignmentCenter;
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textColor = [UIColor whiteColor];
    
    CGRect frame = self.captureView.frame;
    _gPSLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, frame.size.height - 20, 240.0f, 320.0f)];
    _gPSLabel.font = [UIFont systemFontOfSize:14.0f];
    _gPSLabel.text = @"";
    _gPSLabel.textAlignment = UITextAlignmentCenter;
    _gPSLabel.backgroundColor = [UIColor clearColor];
    _gPSLabel.textColor = [UIColor whiteColor];
}

- (void)initSegmentControll;
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    
    [self.segmentControlFilter setTitleTextAttributes:attributes
                                             forState:UIControlStateNormal];
    
    self.segmentControlFilter.segmentedControlStyle = UISegmentedControlStylePlain;
    
    [self.segmentControlFilter addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.segmentControlFilter addTarget:self action:@selector(segmentTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *segmentSelected = [[UIImage imageNamed:@"segment_1px_selected.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"segment_1px_no_select.png"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                        UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f],
                                                        UITextAttributeTextColor : [UIColor whiteColor],}
                                             forState:UIControlStateNormal];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                        UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f],
                                                        UITextAttributeTextColor : [UIColor colorWithRed:0/255.0 green:138/255.0 blue:196/255.0 alpha:1.0],}
                                             forState:UIControlStateSelected];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
                                               forState:UIControlStateNormal
                                             barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
                                               forState:UIControlStateSelected
                                             barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"segment_divider.png"]
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    
    _currentSessionFilter = CameraSetting;
    [self.segmentControlFilter setSelectedSegmentIndex:0];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        self.segmentControlFilter.frame = CGRectMake(self.segmentControlFilter.frame.origin.x, self.segmentControlFilter.frame.origin.y - 15, self.segmentControlFilter.frame.size.width, self.segmentControlFilter.frame.size.height);
    }
}

-(IBAction) segmentTouch:(id)sender;
{

    _currentSessionFilter = _backupFilter;
    
    int height = 0, count = 0;
    count = _backupArray.count;
    [self.tableViewFilter reloadData];

    if (count > maximumItemCount)
    count = maximumItemCount;

    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}

-(IBAction) segmentChange:(id)sender;
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        maximumItemCount = max_ITEM_COUNT_LANDCAPT;
    } else {
        maximumItemCount = max_ITEM_COUNT;
    }
    
    _isChildFilter = NO;
    UISegmentedControl * control = sender;
    
    [self.sliderView setHidden:YES];
    [self.tableViewFilter setHidden:NO];
    
    int selectedIndex = [control selectedSegmentIndex];
    
    switch (selectedIndex) {
        case 0:
            _currentSessionFilter = CameraSetting;
            break;
        case 1:
        {
            if (_isVideoStyle) {
                _currentSessionFilter = VideoSetting;
            } else
                _currentSessionFilter = PhotoSetting;
        }
            break;
        case 2:
            _currentSessionFilter = OtherSetting;
            break;
            
        default:
            break;
    }
    
    _backupFilter = _currentSessionFilter;
    
    [self.tableViewFilter reloadData];
    
    int height = 0, count = 0;
    
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            count = _arrayCamera.count;
            _backupArray = _arrayCamera;
        }
            break;
        case OtherSetting:
        {
            count = _arrayOther.count;
            _backupArray = _arrayOther;
        }
            break;
        case PhotoSetting:
        {
            count = _arrayPhoto.count;
            _backupArray = _arrayPhoto;
        }
            break;
        case VideoSetting:
        {
            count = _arrayVideo.count;
            _backupArray = _arrayVideo;
        }
            break;
        case ChildSetting:
            count = _arrayFilterChildElement.count;
            break;
    }
    
    if (count > maximumItemCount)
        count = maximumItemCount;
    
    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}


#pragma mark -
#pragma mark - IBAction show flash menu

- (IBAction)backgroundGestureAction:(id)sender;
{
    self.flashMenu.hidden = YES;
    self.filterView.hidden = YES;
    self.sliderBar.hidden = YES;
    [self.flashBtn setSelected:NO];
    [self.zoomBtn setSelected:NO];
    [self.optionBtn setSelected:NO];
    
    _isChildFilter = NO;
    
    [self.sliderView setHidden:YES];
    [self.tableViewFilter setHidden:NO];
    
    _currentSessionFilter = _backupFilter;
    
    [self.tableViewFilter reloadData];
    
    int height = 0, count = 0;
    
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            count = _arrayCamera.count;
            _backupArray = _arrayCamera;
        }
            break;
        case OtherSetting:
        {
            count = _arrayOther.count;
            _backupArray = _arrayOther;
        }
            break;
        case PhotoSetting:
        {
            count = _arrayPhoto.count;
            _backupArray = _arrayPhoto;
        }
            break;
        case VideoSetting:
        {
            count = _arrayVideo.count;
            _backupArray = _arrayVideo;
        }
            break;
        case ChildSetting:
            count = _arrayFilterChildElement.count;
            break;
    }
    
    if (count > maximumItemCount)
        count = maximumItemCount;
    
    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);

}

- (IBAction)openPhotoGallery:(id)sender;
{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    
//    [self presentModalViewController:picker animated:YES];
    
    
//    if([UIImagePickerController isSourceTypeAvailable:
//        UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        
//        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
////        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
//        
//        [self presentModalViewController:picker animated:YES];
//    }
    

    GalleryViewController *viewController = [[GalleryViewController alloc] initWithNibName:@"GalleryViewController" bundle:nil];
    [[ApplicationDelegate homeNavigationController] pushViewController:viewController animated:YES];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
//    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)captureAction:(id)sender;
{
    if (_isVideoStyle == YES) {
        
        if (![sender isSelected]) {
            [sender setSelected:YES];
            [self startTimmer];
            
            // Start writer video
            // Record a movie for 10 s and store it in /Documents, visible via iTunes file sharing
            NSDate *currDate = [NSDate date];
            if (_saveFileType == TypeDateTime) {
                [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
            } else {
                [dateFormatter setDateFormat:@"HH:mm:ss dd.MM.YY"];
            }
            
            NSString *type = @"m4v";
            if (_videoFileType == Type3GP) {
                type = @"3gpp";
            }
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Movie_%@.%@", dateString, type]];
            unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
            NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
            
            if (_cameraFilter.captureSessionPreset == AVCaptureSessionPreset352x288) {
                movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(352.0, 288.0)];
            } else if (_cameraFilter.captureSessionPreset == AVCaptureSessionPreset640x480) {
                movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
            } else if (_cameraFilter.captureSessionPreset == AVCaptureSessionPreset1280x720) {
                movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(720.0, 1280.0)];
            } else if (_cameraFilter.captureSessionPreset == AVCaptureSessionPreset1920x1080) {
                movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(1080.0, 1920.0)];
            }

            [_currentVideoFilterAdded addTarget:movieWriter];
            [_filterVideo addTarget:_filterVideoView];
            
            [_cameraFilter startCameraCapture];
            [_filterVideoView setHidden:NO];
            
            [_stillCameraFilter stopCameraCapture];
            [_filteredView setHidden:YES];
            
            // start recoding
            _cameraFilter.audioEncodingTarget = movieWriter;
            [movieWriter startRecording];
            
        } else {
            [sender setSelected:NO];
            [self stopTimmer];
            
            [_currentVideoFilterAdded removeTarget:movieWriter];
            _cameraFilter.audioEncodingTarget = nil;
            [movieWriter finishRecording];
            
            NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
            [self writeMovieToLibraryWithPath:movieURL];
            NSLog(@"Movie completed");
            
            [self resetFilterForVideo];
        }
        return;
    }
    
    [sender setEnabled:NO];
    
    [_stillCameraFilter capturePhotoAsImageProcessedUpToFilter:_filterGroup withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        
        UIImage *imgTemple = processedImage;
        if (_isAddTimeLable) {
            
            NSDate *currDate = [NSDate date];
            [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            
            imgTemple = [self drawText:dateString inImage:processedImage atPoint:CGPointMake(10, 10)];
        }
        
        if (_isAddGPSLable) {
            NSLog(@"%@",_currentLocation);
            imgTemple = [self drawText:_currentLocation inImage:imgTemple atPoint:CGPointMake(10, imgTemple.size.height - 30)];
        }
        
        NSData *dataForPNGFile = UIImageJPEGRepresentation(imgTemple, _photoJPEGQuanlity);
        
        // Save to assets library
        [_assetsLibrary writeImageDataToSavedPhotosAlbum:dataForPNGFile metadata:_stillCameraFilter.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error2)
         {

             [_stillCameraFilter stopCameraCapture];
             [self performSelector:@selector(nextAction)
                        withObject:nil
                        afterDelay:(_previewTime * 1.0f)];
             
             if (error2) {
                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }

             runOnMainQueueWithoutDeadlocking(^{

                 [sender setEnabled:YES];
                 [self resetFilterForPhoto];
             });
         }];
    }];
}

- (IBAction)nextAction;
{
    [_stillCameraFilter startCameraCapture];
}

- (IBAction)closeFilterChildren:(id)sender {
    _isChildFilter = NO;
    
    [self.sliderView setHidden:YES];
    [self.tableViewFilter setHidden:NO];
    
    _currentSessionFilter = _backupFilter;
    
    [self.tableViewFilter reloadData];
    
    int height = 0, count = 0;
    
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            count = _arrayCamera.count;
            _backupArray = _arrayCamera;
        }
            break;
        case OtherSetting:
        {
            count = _arrayOther.count;
            _backupArray = _arrayOther;
        }
            break;
        case PhotoSetting:
        {
            count = _arrayPhoto.count;
            _backupArray = _arrayPhoto;
        }
            break;
        case VideoSetting:
        {
            count = _arrayVideo.count;
            _backupArray = _arrayVideo;
        }
            break;
        case ChildSetting:
            count = _arrayFilterChildElement.count;
            break;
    }
    
    if (count > maximumItemCount)
        count = maximumItemCount;
    
    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}


- (void)reloadTableFilter;
{
    [self.tableViewFilter reloadData];
    
    int height = 0, count = 0;
    
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            count = _arrayCamera.count;
            _backupArray = _arrayCamera;
        }
            break;
        case OtherSetting:
        {
            count = _arrayOther.count;
            _backupArray = _arrayOther;
        }
            break;
        case PhotoSetting:
        {
            count = _arrayPhoto.count;
            _backupArray = _arrayPhoto;
        }
            break;
        case VideoSetting:
        {
            count = _arrayVideo.count;
            _backupArray = _arrayVideo;
        }
            break;
        case ChildSetting:
            count = _arrayFilterChildElement.count;
            break;
    }
    
    if (count > maximumItemCount)
        count = maximumItemCount;
    
    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}

-(IBAction)actionFilterOption:(id)sender
{
    [self.flashBtn setSelected:NO];
    [self.zoomBtn setSelected:NO];
    
    self.sliderBar.hidden = YES;
    self.flashMenu.hidden = YES;

    if (self.filterView.hidden) {
        self.filterView.hidden = NO;
        [self.optionBtn setSelected:YES];
    }
    else {
        
        _isChildFilter = NO;
        
        [self.sliderView setHidden:YES];
        [self.tableViewFilter setHidden:NO];
        
        _currentSessionFilter = _backupFilter;
        
        [self reloadTableFilter];
        
        [self.optionBtn setSelected:NO];
        self.filterView.hidden = YES;
    }
}

-(IBAction)showFlashMenuPress:(id)sender
{
    if (_isNoFlashLight) {
        return;
    }
    
    [self.optionBtn setSelected:NO];
    [self.zoomBtn setSelected:NO];
    self.sliderBar.hidden = YES;
    self.filterView.hidden = YES;
    
    if (self.flashMenu.hidden) {
        self.flashMenu.hidden = NO;
        self.filterView.hidden = YES;
        [self.flashBtn setSelected:YES];
    }
    else {
        self.flashMenu.hidden = YES;
        [self.flashBtn setSelected:NO];
    }
}

-(IBAction)zoomPress:(id)sender
{
    [self.flashBtn setSelected:NO];
    [self.optionBtn setSelected:NO];
    self.flashMenu.hidden = YES;
    self.filterView.hidden = YES;
    
    if (self.sliderBar.hidden) {
        [self.zoomBtn setSelected:YES];
        self.sliderBar.hidden = NO;
        
        [self addFilterForCaptureStillCameraWith:transformFilter];
    } else {
        [self.zoomBtn setSelected:NO];
        self.sliderBar.hidden = YES;
    }    
}

-(IBAction)actionAutoFlash:(id)sender;
{
    [self.flAutoBtn setSelected:YES];
    [self.flAlwayBtn setSelected:NO];
    [self.flNoneBtn setSelected:NO];
    [self.flSoundBtn setSelected:NO];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-auto.png"]
                   forState:UIControlStateNormal];
    
    _flashLight = FlashLightAuto;
    
    BOOL success = [flashLight lockForConfiguration:nil];
    if(success){
        [flashLight setTorchMode:AVCaptureTorchModeAuto];
        [flashLight setFlashMode:AVCaptureFlashModeAuto];
        [flashLight unlockForConfiguration];
    }
}

-(IBAction)actionAlwayFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:YES];
    [self.flNoneBtn setSelected:NO];
    [self.flSoundBtn setSelected:NO];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash.png"]
                   forState:UIControlStateNormal];
    
    _flashLight = FlashLightOn;
    
    BOOL success = [flashLight lockForConfiguration:nil];
    if(success){
        [flashLight setTorchMode:AVCaptureTorchModeOn];
        [flashLight setFlashMode:AVCaptureFlashModeOn];
        [flashLight unlockForConfiguration];
    }
}

-(IBAction)actionNoneFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:NO];
    [self.flNoneBtn setSelected:YES];
    [self.flSoundBtn setSelected:NO];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-off.png"]
                   forState:UIControlStateNormal];
    
    _flashLight = FlashLightOff;
    
    BOOL success = [flashLight lockForConfiguration:nil];
    if(success){
        [flashLight setTorchMode:AVCaptureTorchModeOff];
        [flashLight setFlashMode:AVCaptureFlashModeOff];
        [flashLight unlockForConfiguration];
    }
}

-(IBAction)actionSoundFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:NO];
    [self.flNoneBtn setSelected:NO];
    [self.flSoundBtn setSelected:YES];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-sound.png"]
                   forState:UIControlStateNormal];
    
    _flashLight = FlashLightOff;
    
    BOOL success = [flashLight lockForConfiguration:nil];
    if(success){
        [flashLight setTorchMode:AVCaptureTorchModeOff];
        [flashLight setFlashMode:AVCaptureFlashModeOff];
        [flashLight unlockForConfiguration];
    }
}

- (IBAction)changeVideoMode:(id)sender {
    
    if (_isVideoStyle == NO) {
        NSLog(@"Change Mode Video");
        [self resetFilterForPhoto];
        
        [self.segmentControlFilter setTitle:@"Video" forSegmentAtIndex:1];
        
        if (_backupFilter == PhotoSetting) {
            _backupFilter = VideoSetting;
        }
        
        self.videoView.hidden = NO;
        self.timmerLable.text = @"0' 00'' 00";
        [self.captureBtn setBackgroundImage:[UIImage imageNamed:@"camera_start_rotate_image.png"] forState:UIControlStateNormal];
        [self.captureBtn setBackgroundImage:[UIImage imageNamed:@"camera_rotate_image.png"] forState:UIControlStateSelected];
        
        if (_stillCameraFilter) {
            [_stillCameraFilter stopCameraCapture];
        }
        
        [_cameraFilter startCameraCapture];
        
        [_filteredView setHidden:YES];
        [_filterVideoView setHidden:NO];
        
    } else {
        NSLog(@"Change Photo");
        [self resetFilterForVideo];
        
        [self.segmentControlFilter setTitle:@"Photo" forSegmentAtIndex:1];
        
        if (_backupFilter == VideoSetting) {
            _backupFilter = PhotoSetting;
        }
        
        self.videoView.hidden = YES;
        [self.captureBtn setBackgroundImage:[UIImage imageNamed:@"video_capture_icon.png"] forState:UIControlStateNormal];
        [self.captureBtn setBackgroundImage:[UIImage imageNamed:@"video_capture_icon.png"] forState:UIControlStateSelected];
        
        if (_cameraFilter) {
            [_cameraFilter stopCameraCapture];
        }
        [_stillCameraFilter startCameraCapture];
        
        [_filteredView setHidden:NO];
        [_filterVideoView setHidden:YES];
    }
    
    _isVideoStyle = !_isVideoStyle;
    
    _isChildFilter = NO;
    
    [self.sliderView setHidden:YES];
    [self.tableViewFilter setHidden:NO];
    
    _currentSessionFilter = _backupFilter;
    
    [self.tableViewFilter reloadData];
    
    int height = 0, count = 0;
    
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            count = _arrayCamera.count;
            _backupArray = _arrayCamera;
        }
            break;
        case OtherSetting:
        {
            count = _arrayOther.count;
            _backupArray = _arrayOther;
        }
            break;
        case PhotoSetting:
        {
            count = _arrayPhoto.count;
            _backupArray = _arrayPhoto;
        }
            break;
        case VideoSetting:
        {
            count = _arrayVideo.count;
            _backupArray = _arrayVideo;
        }
            break;
        case ChildSetting:
            count = _arrayFilterChildElement.count;
            break;
    }
    
    if (count > maximumItemCount)
        count = maximumItemCount;
    
    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}

#pragma mark -
#pragma mark - Init Filter Data

-(void)initListFilterData;
{
    if (!_filterManager) {
        _filterManager = [[PSFilterManager alloc] initWithView:self.captureView];
    }
    
    _arrayCamera = _filterManager.arrayCameraSetting;
    _arrayPhoto = _filterManager.arrayPhotoSetting;
    _arrayOther = _filterManager.arrayOthersSetting;
    _arrayVideo = _filterManager.arrayVideoSetting;
    
    [self.tableViewFilter reloadData];
}


#pragma mark -
#pragma mark - Init GPUImage Filter camera and Photo

- (void)initGPUImageToView;
{
    flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight hasTorch] || [flashLight hasFlash]) {
        _flashLight = FlashLightAuto;
        _isNoFlashLight = NO;
        
        BOOL success = [flashLight lockForConfiguration:nil];
        if(success){
            [flashLight setTorchMode:AVCaptureTorchModeAuto];
            [flashLight setFlashMode:AVCaptureFlashModeAuto];
            [flashLight unlockForConfiguration];
        }
        
        [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-auto.png"]
                       forState:UIControlStateNormal];
        
    } else {
        _flashLight = FlashLightOff;
        _isNoFlashLight = YES;
        [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-off.png"]
                       forState:UIControlStateNormal];
    }
    
    // Config screen for FilterView
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.captureView.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    _filteredView = [[GPUImageView alloc] initWithFrame:screenRect];
    _filteredView.autoresizesSubviews = YES;
    _filteredView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_filteredView setFillMode:kGPUImageFillModeStretch];
    
    // Init filter for still camera
    _stillCameraFilter = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetMedium cameraPosition:AVCaptureDevicePositionBack];
    _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    _filterGroup = [[GPUImageFilterGroup alloc] init];
    
    GPUImageOutput<GPUImageInput> *ExposureFilter = [[GPUImageExposureFilter alloc] init];
    [(GPUImageExposureFilter *)ExposureFilter setExposure:0];

    _currentFilterInput = ExposureFilter;
    _firstFilterInput = ExposureFilter;
    
    _currentFilterArray = [[NSMutableArray alloc] init];
    [_currentFilterArray addObject:ExposureFilter];
    [(GPUImageFilterGroup *)_filterGroup addTarget:_currentFilterInput];
    
    [(GPUImageFilterGroup *)_filterGroup setInitialFilters:[NSArray arrayWithObject:_firstFilterInput]];
    [(GPUImageFilterGroup *)_filterGroup setTerminalFilter:_currentFilterInput];
    [_filterGroup prepareForImageCapture];
    
    [_stillCameraFilter addTarget:_currentFilterInput];
    
    [_filterGroup addTarget:_filteredView];
    
    
    // Add filterview and start camera
    [self.captureView addSubview:_filteredView];
    [_stillCameraFilter startCameraCapture];

    // ------------------------------
    // Init filter for camera
    _cameraFilter = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    
    _cameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
    _cameraFilter.horizontallyMirrorFrontFacingCamera = NO;
    _cameraFilter.horizontallyMirrorRearFacingCamera = NO;

    _filterVideoView = [[GPUImageView alloc] initWithFrame:screenRect];
    _filterVideoView.autoresizesSubviews = YES;
    _filterVideoView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_filterVideoView setFillMode:kGPUImageFillModeStretch];
    
    _filterVideo = [[GPUImageFilter alloc] init];
    [_filterVideo addTarget:ExposureFilter];
    _currentVideoFilterAdded = _filterVideo;
    [_cameraFilter addTarget:_filterVideo];
    
    // Record a movie for 10 s and store it in /Documents, visible via iTunes file sharing
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    
    [_filterVideo addTarget:movieWriter];
    [_filterVideo addTarget:_filterVideoView];
    
    [self.captureView addSubview:_filterVideoView];
    [_cameraFilter stopCameraCapture];
    [_filterVideoView setHidden:YES];
    
    
    _photoJPEGQuanlity = 1;
    _idHDRPresetHigh = NO;
    _isStabilizer = NO;
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    blendTimeFilter = [[GPUImageAlphaBlendFilter alloc] init];
    blendTimeFilter.mix = 1.0;
    blendGPSFilter = [[GPUImageAlphaBlendFilter alloc] init];
    blendGPSFilter.mix = 1.0;
}


#pragma mark -
#pragma mark - ViewController Method

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // Check rotation
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        
        [self changeUILandscapeRotation];
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation)) {
        [self changeUIPortraitRotation];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.gridviewImg setHidden:YES];
    _saveFileType = TypeDateTime;
    _videoFileType = TypeMPEG4;
    _isAutoRotationVideo = NO;
    _previewTime = 0;
    
    locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    
    max_ITEM_COUNT = 8;
    
    if (IS_IPHONE_5)
        max_ITEM_COUNT = 8;
    else
        max_ITEM_COUNT = 5;
    max_ITEM_COUNT_LANDCAPT = 5;
    maximumItemCount = max_ITEM_COUNT_LANDCAPT;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    _isVideoStyle = NO;
    // Do any additional setup after loading the view from its nib.
    
    [self initSegmentControll];
    
    self.filterView.backgroundColor = [UIColor clearColor];
    [self.tableViewFilter setSeparatorColor:[UIColor colorWithRed:255.0f/255.0f
                                                            green:255.0f/255.0f
                                                             blue:255.0f/255.0f
                                                            alpha:0.4]];
    self.tableViewFilter.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
    
    [self initListFilterData];
    [self initUIButtonControll];
    
    self.sliderBar.hidden = YES;
    self.filterView.hidden = YES;
    self.flashMenu.hidden = YES;
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundGestureAction:)];
    tapGestureRecognize.delegate = self;
    tapGestureRecognize.numberOfTapsRequired = 1;
    [self.captureView addGestureRecognizer:tapGestureRecognize];
    [self.captureView setUserInteractionEnabled:YES];
    self.captureView.backgroundColor = [UIColor clearColor];
    
    if ([GPUImageContext supportsFastTextureUpload])
    {
        NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
        self.faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
        faceThinking = NO;
    }
    
    // Init gpuimage
    [self initGPUImageToView];
    
    TVCalibratedSliderRange range;
    range.maximumValue = 5;
    range.minimumValue = 1;
    
    [self.scaledSlider setRange:range];
    [self.scaledSlider setValue:1];
    [self.scaledSlider setTextColorForHighlightedState:[UIColor whiteColor]];
    [self.scaledSlider setStyle:TavicsaStyle];

    // UISlider update value filter
    self.scaledSlider.tvSliderValueChangedBlock = ^(id sender) {
        
        float value = [(TVCalibratedSlider *)sender value];
        
        [self sliderFilterValueChange:value];
    };
    
    self.filterValue.layer.cornerRadius = 5.0f;
    self.filterValue.layer.borderWidth = 1.5f;
    self.filterValue.layer.borderColor = [[UIColor blueColor] CGColor];
    
    [self.sliderView setHidden:YES];
    self.videoView.hidden = YES;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm : ss : S"];
    
    // Check rotation
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        
        [self changeUILandscapeRotation];
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation)) {
        [self changeUIPortraitRotation];
    }
}

- (void)startTimmer;
{
    _ticks = 0;
    if (!pollingTimer) {
        pollingTimer = [NSTimer scheduledTimerWithTimeInterval:kPollingInterval
                                                        target:self
                                                      selector:@selector(timerFired:)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

- (void)stopTimmer;
{
    if (pollingTimer != nil) {
        [pollingTimer invalidate];
        pollingTimer = nil;
    }
}

-(void)timerFired:(NSTimer *) theTimer
{
//    NSLog(@"timerFired @ %@", [theTimer fireDate]);
//    NSDate *today = [[NSDate alloc] init];
//    NSString *currentTime = [dateFormatter stringFromDate: [theTimer fireDate]];
    
    // Timers are not guaranteed to tick at the nominal rate specified, so this isn't technically accurate.
    // However, this is just an example to demonstrate how to stop some ongoing activity, so we can live with that inaccuracy.
    _ticks += 0.1;
    double seconds = fmod(_ticks, 60.0);
    double minutes = fmod(trunc(_ticks / 60.0), 60.0);
    double hours = trunc(_ticks / 3600.0);
    self.timmerLable.text = [NSString stringWithFormat:@"%02.0f' %02.0f'' %02.0f", hours, minutes, seconds];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Note: I needed to stop camera capture before the view went off the screen in order to prevent a crash from the camera still sending frames
//    if (_cameraFilter) {
//        [_cameraFilter stopCameraCapture];
//    }
//    
//    if (_stillCameraFilter) {
//        [_stillCameraFilter stopCameraCapture];
//    }
    
    
    [super viewWillDisappear:animated];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** UITableView delegate **
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_HEIGHT;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (_currentSessionFilter) {
        case CameraSetting:
            return _arrayCamera.count;
            break;
        case OtherSetting:
            return _arrayOther.count;
            break;
        case PhotoSetting:
            return _arrayPhoto.count;
            break;
        case VideoSetting:
            return _arrayVideo.count;
            break;
        case ChildSetting:
            return _currentParentFilterObject.arrayValue.count;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PSCustomCell";
    
    PSCustomCell *cell = (PSCustomCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PSCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.switchBtn.arrange = CustomSwitchArrangeONLeftOFFRight;
        cell.switchBtn.onImage = [UIImage imageNamed:@"switchOne_on.png"];
        cell.switchBtn.offImage = [UIImage imageNamed:@"switchOne_off.png"];
        cell.switchBtn.status = CustomSwitchStatusOff;
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.detailLabel.textColor = [UIColor whiteColor];
        cell.switchDelegate = self;
    }
    
    cell.isChild = NO;
    PSFilterData* object;
    switch (_currentSessionFilter) {
        case CameraSetting:
            object = [_arrayCamera objectAtIndex:indexPath.row];
            break;
        case OtherSetting:
            object = [_arrayOther objectAtIndex:indexPath.row];
            break;
        case PhotoSetting:
            object = [_arrayPhoto objectAtIndex:indexPath.row];
            break;
        case VideoSetting:
            object = [_arrayVideo objectAtIndex:indexPath.row];
            break;
        case ChildSetting:
        {
            object = _currentParentFilterObject;
            cell.isChild = YES;
        }
            break;
    }
    
    cell.tag = indexPath.row;
    [cell setDataForCustomCell:object];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"indexPath.row = %d", indexPath.row);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int height = 0, count = 0;
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            _backupFilter = _currentSessionFilter;
            _currentParentFilterObject = [_arrayCamera objectAtIndex:indexPath.row];
            if (_currentParentFilterObject.switchValue != -1)
                return;
                
            _backupArray = _arrayCamera;
            _currentSessionFilter = ChildSetting;
            count = _currentParentFilterObject.arrayValue.count;
            
            PSFilterData* object = [_arrayCamera objectAtIndex:indexPath.row];
            // Check filter type camera
            switch (object.cameraType) {
                case FilterTypeExposureMode:
                case FilterTypeExposureCompensation:
                case FilterTypeMotionDetector:
                {
                    [self.sliderView setHidden:NO];
                    [self.tableViewFilter setHidden:YES];
                    
                    self.filterTitle.text = object.filterTitle;
                    if (object.indexValue < 0) {
                        object.indexValue = 0;
                    }
                    self.filterValue.text = [NSString stringWithFormat:@"%d", object.indexValue];
                    
                    TVCalibratedSliderRange range;
                    range.maximumValue = 8;
                    range.minimumValue = 0;
                    
                    [self.scaledSlider setRange:range];
                    [self.scaledSlider setValue:object.indexValue];

                }
                    break;
                case FilterTypeFocusMode:
                case FilterTypeBrightness:
                case FilterTypeContrast:
                case FilterTypeSaturation:
                case FilterTypeSharpness:
                case FilterTypeCrop:
                {
                    [self.sliderView setHidden:NO];
                    [self.tableViewFilter setHidden:YES];
                    
                    self.filterTitle.text = object.filterTitle;
                    if (object.indexValue < 0) {
                        object.indexValue = 0;
                    }
                    self.filterValue.text = [NSString stringWithFormat:@"%d", object.indexValue];
                    
                    TVCalibratedSliderRange range;
                    range.maximumValue = 6;
                    range.minimumValue = 0;
                    
                    [self.scaledSlider setRange:range];
                    [self.scaledSlider setValue:object.indexValue];
                    
                }
                    break;
                    
                case FilterTypeTransform_2D:
                case FilterTypeTransform_3D:
                {
                    [self.sliderView setHidden:NO];
                    [self.tableViewFilter setHidden:YES];
                    
                    self.filterTitle.text = object.filterTitle;
                    if (object.indexValue < 0) {
                        object.indexValue = 0;
                    }
                    self.filterValue.text = [NSString stringWithFormat:@"%d", object.indexValue];
                    
                    TVCalibratedSliderRange range;
                    range.maximumValue = 16;
                    range.minimumValue = 0;
                    
                    [self.scaledSlider setRange:range];
                    [self.scaledSlider setValue:object.indexValue];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case VideoSetting:
        {
            _backupFilter = _currentSessionFilter;
            _currentParentFilterObject = [_arrayVideo objectAtIndex:indexPath.row];
            if (_currentParentFilterObject.switchValue != -1)
                return;
            
            _backupArray = _arrayVideo;
            _currentSessionFilter = ChildSetting;
            count = _currentParentFilterObject.arrayValue.count;
        }
            break;
        case PhotoSetting:
        {
            _backupFilter = _currentSessionFilter;
            _currentParentFilterObject = [_arrayPhoto objectAtIndex:indexPath.row];
            if (_currentParentFilterObject.switchValue != -1)
                return;
            
            _backupArray = _arrayPhoto;
            _currentSessionFilter = ChildSetting;
            count = _currentParentFilterObject.arrayValue.count;
            
            PSFilterData* object = [_arrayPhoto objectAtIndex:indexPath.row];
            // Check filter type photo
            switch (object.photoType) {
                case PhotoJPEGQuanlity:
                {
                    [self.sliderView setHidden:NO];
                    [self.tableViewFilter setHidden:YES];
                    
                    self.filterTitle.text = object.filterTitle;
                    if (object.indexValue < 0) {
                        object.indexValue = 1;
                    }
                    self.filterValue.text = [NSString stringWithFormat:@"%d", object.indexValue];
                    
                    TVCalibratedSliderRange range;
                    range.maximumValue = 10;
                    range.minimumValue = 1;
                    
                    [self.scaledSlider setRange:range];
                    [self.scaledSlider setValue:object.indexValue];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case OtherSetting:
        {
            _backupFilter = _currentSessionFilter;
            _currentParentFilterObject = [_arrayOther objectAtIndex:indexPath.row];
            if (_currentParentFilterObject.switchValue != -1)
                return;
            
            _backupArray = _arrayOther;
            _currentSessionFilter = ChildSetting;
            count = _currentParentFilterObject.arrayValue.count;
            
        }
            break;
        case ChildSetting:
        {
            [self.sliderView setHidden:YES];
            [self.tableViewFilter setHidden:NO];
            
            _currentParentFilterObject.indexValue = indexPath.row;
            _currentSessionFilter = _backupFilter;
            count = _backupArray.count;
            
            GPUImageOutput<GPUImageInput> *filtera = [[GPUImageSketchFilter alloc] init];
            [_stillCameraFilter addTarget:filtera];
            
            // Add filter for GPUImage
            switch (_currentSessionFilter) {
                case CameraSetting:
                    
                    [self addFilterForCaptureStillCameraWith:[_filterManager filterCameraTypeWithFilterType:_currentParentFilterObject.cameraType andValue:indexPath.row]];
                    
                    break;
                case VideoSetting:
                {
                    if (_currentParentFilterObject.videoType == RotateVideoFileFormat) {
                        if (indexPath.row == 0) {
                            _videoFileType = Type3GP;
                        } else
                            _videoFileType = TypeMPEG4;
                    } else if (_currentParentFilterObject.videoType == RotateVideoResolution) {
                        
                        switch (indexPath.row) {
                            case 0:
                                [_cameraFilter setCaptureSessionPreset:AVCaptureSessionPreset352x288];
                                break;
                            case 1:
                                [_cameraFilter setCaptureSessionPreset:AVCaptureSessionPreset640x480];
                                break;
                            case 2:
                                [_cameraFilter setCaptureSessionPreset:AVCaptureSessionPreset1280x720];
                                break;
                            case 3:
                                [_cameraFilter setCaptureSessionPreset:AVCaptureSessionPreset1920x1080];
                                break;
                            default:
                                break;
                        }
                    }
                }
                    break;
                case PhotoSetting:
                {
                    if (_currentParentFilterObject.photoType == PhotoResolution) {
                        
                        _photoResolution = [_currentParentFilterObject.arrayValue objectAtIndex:indexPath.row];
                        
                        switch (indexPath.row) {
                            case 0:
                                [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPreset352x288];
                                break;
                            case 1:
                                [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPreset640x480];
                                break;
                            case 2:
                                [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPreset1280x720];
                                break;
                            case 3:
                                [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPreset1920x1080];
                                break;
                            default:
                                break;
                        }
                        
                    } else {
                        [self addFilterForCaptureStillCameraWith:[_filterManager filterPhotoTypeWithFilterType:_currentParentFilterObject.photoType andValue:indexPath.row]];
                    }
                }
                    break;
                case OtherSetting:
                {
                    if (_currentParentFilterObject.otherType == OthersPreviewTime) {
                        _previewTime = indexPath.row;
                    } else
                    if (_currentParentFilterObject.otherType == OthersFormatFileNames) {
                        if (indexPath.row == 0)
                            _saveFileType = TypeDateTime;
                        else
                            _saveFileType = TypeClockTime;
                    } else
                        [self addFilterForCaptureStillCameraWith:[_filterManager filterOtherTypeWithFilterType:_currentParentFilterObject.otherType andValue:indexPath.row]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
    }
    
    [self.tableViewFilter reloadData];
    
    if (count > maximumItemCount)
        count = maximumItemCount;

    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}

- (void)addFilterForCaptureStillCameraWith:(GPUImageOutput<GPUImageInput> *)filterAdded;
{
    if (!filterAdded)
        return;
    
    if ([_currentFilterArray containsObject:filterAdded]) {
        return;
    }
    
    // Save list filter
    [_currentFilterArray addObject:filterAdded];
    
    [_filterGroup removeAllTargets];
    if (_isVideoStyle == YES) {
        [_cameraFilter removeAllTargets];
        [self addFilterForVideoCameraWith:filterAdded];
        
        return;
    } else
        [_stillCameraFilter removeAllTargets];
    
    [_filterGroup addTarget:filterAdded];
    
    [(GPUImageFilterGroup *)_filterGroup setInitialFilters:[NSArray arrayWithObject:_firstFilterInput]];
    [(GPUImageFilterGroup *)_filterGroup setTerminalFilter:filterAdded];
    
    [_filterGroup prepareForImageCapture];
    
    [_filterGroup addTarget:_filteredView];
    [_stillCameraFilter addTarget:_filterGroup];
}

- (void)addFilterForVideoCameraWith:(GPUImageOutput<GPUImageInput> *)filterAdded;
{
    [_firstFilterInput addTarget:filterAdded];
    [filterAdded addTarget:_filterVideoView];
    [_cameraFilter addTarget:filterAdded];
    
    _currentVideoFilterAdded = filterAdded;
}

- (void)resetFilterForPhoto;
{
    [_currentFilterArray removeAllObjects];
    [_filterGroup removeAllTargets];
    [_stillCameraFilter removeAllTargets];
    [(GPUImageFilterGroup *)_filterGroup setInitialFilters:[NSArray arrayWithObject:_firstFilterInput]];
    [(GPUImageFilterGroup *)_filterGroup setTerminalFilter:_currentFilterInput];

    [_filterGroup prepareForImageCapture];
    
    [_filterGroup addTarget:_filteredView];
    [_stillCameraFilter addTarget:_filterGroup];
    
    for (PSFilterData *data in _arrayCamera) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayPhoto) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayVideo) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayOther) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    [self reloadTableFilter];
}

- (void)resetFilterForVideo;
{
    [_currentFilterArray removeAllObjects];
    [_filterVideo removeAllTargets];
    _currentVideoFilterAdded = _filterVideo;
    [_firstFilterInput addTarget:_currentVideoFilterAdded];
    [_currentVideoFilterAdded addTarget:_filterVideoView];
    [_cameraFilter addTarget:_currentVideoFilterAdded];
    
    for (PSFilterData *data in _arrayCamera) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayPhoto) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayVideo) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    for (PSFilterData *data in _arrayOther) {
        if (data.switchValue != -1) {
            [data setSwitchValue:0];
        }
        [data setIndexValue:-1];
    }
    
    [self reloadTableFilter];
}

-(void)changeSwitchStatus:(BOOL)status filterData:(PSFilterData *)data atIndex:(int)index;
{
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
            // Face detect
            if (data.cameraType == FilterTypeFaceDetection) {
                
                if (!status) {
                    
                    [_stillCameraFilter setDelegate:nil];
                    if (faceView) {
                        [faceView removeFromSuperview];
                        faceView = nil;
                    }
                } else {
                    
                    [_stillCameraFilter setDelegate:self];
                    
                }
            }
        }
            break;
        case OtherSetting:
        {
            if (data.otherType == OthersShowGrid) {
                if (status) {
                    [self.gridviewImg setHidden:NO];
                } else {
                    [self.gridviewImg setHidden:YES];
                }
            }
        }
            break;
        case PhotoSetting:
        {
            // Photo stabilizer
            if (data.photoType == PhotoStabilizer) {
                
                AVCaptureConnection *videoConnection = [_stillCameraFilter videoCaptureConnection];
                if (!status) {
                    if ([videoConnection isVideoStabilizationSupported] && _isStabilizer)
                    {
                        _isStabilizer = NO;
                        NSLog(@"VideoStabilizationSupported! Curr val: %i", [videoConnection isVideoStabilizationEnabled]);
                        if (![videoConnection isVideoStabilizationEnabled]) {
                            NSLog(@"enabling Video Stabilization!");
                            [_stillCameraFilter stopCameraCapture];
                            videoConnection.enablesVideoStabilizationWhenAvailable= YES;
                            [_stillCameraFilter startCameraCapture];
                            NSLog(@"after: %i", [videoConnection isVideoStabilizationEnabled]);
                        }
                    }
                } else {
                    if ([videoConnection isVideoStabilizationSupported])
                    {
                        _isStabilizer = YES;
                        NSLog(@"VideoStabilizationSupported! Curr val: %i", [videoConnection isVideoStabilizationEnabled]);
                        if ([videoConnection isVideoStabilizationEnabled]) {
                            NSLog(@"enabling Video Stabilization!");
                            
                            [_stillCameraFilter stopCameraCapture];
                            videoConnection.enablesVideoStabilizationWhenAvailable= NO;
                            [_stillCameraFilter startCameraCapture];
                            NSLog(@"after: %i", [videoConnection isVideoStabilizationEnabled]);
                        }
                    }
                }
            } else if (data.photoType == PhotoDelayJPEG) {
                
                NSLog(@"PhotoDelayJPEG");
                _idHDRPresetHigh = status;
                
                if (status) {
                    [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPresetHigh];
                } else {
                    [_stillCameraFilter setCaptureSessionPreset:AVCaptureSessionPresetMedium];
                }
                
            } else if (data.photoType == PhotoOverlay) {
                _isAddTimeLable = status;
            } else if (data.photoType == PhotoSaveGPS) {
                _isAddGPSLable = status;
                if (status == YES) {
                    locationManager.delegate = self;
                    [locationManager startUpdatingLocation];
                }
            }
        }
            break;
        case VideoSetting:
        {
            if (data.videoType == RotateAutoRotateVideo) {
                _isAutoRotationVideo = status;
            }
        }
            break;
        case ChildSetting:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
    _currentLocation = @"";
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    if (_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    [_geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemark, NSError *error) {
        
        CLPlacemark *pm = [placemark objectAtIndex:0];
        // do something with the address, see keys in the remark below
        NSLog(@"name: %@", pm.name);
        NSString *address = [NSString stringWithFormat:@"%@", pm.name];
        
        if (address == nil || [address isEqualToString:@""] || [address isEqualToString:@"(null)"]) {
            _currentLocation = @"";
        } else {
            _currentLocation = address;
        }
    }];
    
    [locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark - Face Detection Delegate Callback
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    if (!faceThinking) {
        CFAllocatorRef allocator = CFAllocatorGetDefault();
        CMSampleBufferRef sbufCopyOut;
        CMSampleBufferCreateCopy(allocator,sampleBuffer,&sbufCopyOut);
        [self performSelectorInBackground:@selector(grepFacesForSampleBuffer:) withObject:CFBridgingRelease(sbufCopyOut)];
    }
}

- (void)grepFacesForSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    faceThinking = TRUE;
    NSLog(@"Faces thinking");
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
	CIImage *convertedImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer options:(__bridge NSDictionary *)attachments];
    
	if (attachments)
		CFRelease(attachments);
	NSDictionary *imageOptions = nil;
	UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
	int exifOrientation;
	
    /* kCGImagePropertyOrientation values
     The intended display orientation of the image. If present, this key is a CFNumber value with the same value as defined
     by the TIFF and EXIF specifications -- see enumeration of integer constants.
     The value specified where the origin (0,0) of the image is located. If not present, a value of 1 is assumed.
     
     used when calling featuresInImage: options: The value for this key is an integer NSNumber from 1..8 as found in kCGImagePropertyOrientation.
     If present, the detection will be done based on that orientation but the coordinates in the returned features will still be based on those of the image. */
    
	enum {
		PHOTOS_EXIF_0ROW_TOP_0COL_LEFT			= 1, //   1  =  0th row is at the top, and 0th column is on the left (THE DEFAULT).
		PHOTOS_EXIF_0ROW_TOP_0COL_RIGHT			= 2, //   2  =  0th row is at the top, and 0th column is on the right.
		PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT      = 3, //   3  =  0th row is at the bottom, and 0th column is on the right.
		PHOTOS_EXIF_0ROW_BOTTOM_0COL_LEFT       = 4, //   4  =  0th row is at the bottom, and 0th column is on the left.
		PHOTOS_EXIF_0ROW_LEFT_0COL_TOP          = 5, //   5  =  0th row is on the left, and 0th column is the top.
		PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP         = 6, //   6  =  0th row is on the right, and 0th column is the top.
		PHOTOS_EXIF_0ROW_RIGHT_0COL_BOTTOM      = 7, //   7  =  0th row is on the right, and 0th column is the bottom.
		PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM       = 8  //   8  =  0th row is on the left, and 0th column is the bottom.
	};
	BOOL isUsingFrontFacingCamera = FALSE;
    AVCaptureDevicePosition currentCameraPosition = [_stillCameraFilter cameraPosition];
    
    if (currentCameraPosition != AVCaptureDevicePositionBack)
    {
        isUsingFrontFacingCamera = TRUE;
    }
    
	switch (curDeviceOrientation) {
		case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
			exifOrientation = PHOTOS_EXIF_0ROW_LEFT_0COL_BOTTOM;
			break;
		case UIDeviceOrientationLandscapeLeft:       // Device oriented horizontally, home button on the right
			if (isUsingFrontFacingCamera)
				exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
			else
				exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
			break;
		case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
			if (isUsingFrontFacingCamera)
				exifOrientation = PHOTOS_EXIF_0ROW_TOP_0COL_LEFT;
			else
				exifOrientation = PHOTOS_EXIF_0ROW_BOTTOM_0COL_RIGHT;
			break;
		case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
		default:
			exifOrientation = PHOTOS_EXIF_0ROW_RIGHT_0COL_TOP;
			break;
	}
    
	imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:exifOrientation] forKey:CIDetectorImageOrientation];
    
//    NSLog(@"Face Detector %@", [self.faceDetector description]);
//    NSLog(@"converted Image %@", [convertedImage description]);
    NSArray *features = [self.faceDetector featuresInImage:convertedImage options:imageOptions];
    
    
    // get the clean aperture
    // the clean aperture is a rectangle that defines the portion of the encoded pixel dimensions
    // that represents image data valid for display.
    CMFormatDescriptionRef fdesc = CMSampleBufferGetFormatDescription(sampleBuffer);
    CGRect clap = CMVideoFormatDescriptionGetCleanAperture(fdesc, false /*originIsTopLeft == false*/);
    
    
    [self GPUVCWillOutputFeatures:features forClap:clap andOrientation:curDeviceOrientation];
    faceThinking = FALSE;
    
}

- (void)GPUVCWillOutputFeatures:(NSArray*)featureArray forClap:(CGRect)clap
                 andOrientation:(UIDeviceOrientation)curDeviceOrientation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Did receive array");
        
        CGRect previewBox = self.view.frame;
        
        if (featureArray == nil && faceView) {
            [faceView removeFromSuperview];
            faceView = nil;
        }
        
        
        for ( CIFaceFeature *faceFeature in featureArray) {
            
            // find the correct position for the square layer within the previewLayer
            // the feature box originates in the bottom left of the video frame.
            // (Bottom right if mirroring is turned on)
            NSLog(@"%@", NSStringFromCGRect([faceFeature bounds]));
            
            //Update face bounds for iOS Coordinate System
            CGRect faceRect = [faceFeature bounds];
            
            // flip preview width and height
            CGFloat temp = faceRect.size.width;
            faceRect.size.width = faceRect.size.height;
            faceRect.size.height = temp;
            temp = faceRect.origin.x;
            faceRect.origin.x = faceRect.origin.y;
            faceRect.origin.y = temp;
            // scale coordinates so they fit in the preview box, which may be scaled
            CGFloat widthScaleBy = previewBox.size.width / clap.size.height;
            CGFloat heightScaleBy = previewBox.size.height / clap.size.width;
            faceRect.size.width *= widthScaleBy;
            faceRect.size.height *= heightScaleBy;
            faceRect.origin.x *= widthScaleBy;
            faceRect.origin.y *= heightScaleBy;
            
            faceRect = CGRectOffset(faceRect, previewBox.origin.x, previewBox.origin.y);
            
            if (faceView) {
                [faceView removeFromSuperview];
                faceView =  nil;
            }
            
            // create a UIView using the bounds of the face
            faceView = [[UIView alloc] initWithFrame:faceRect];
            
            // add a border around the newly created UIView
            faceView.layer.borderWidth = 1;
            faceView.layer.borderColor = [[UIColor redColor] CGColor];
            
            // add the new view to create a box around the face
            [self.view addSubview:faceView];
            
        }
    });
    
}

-(void)motionDetectFilter;
{
    if (!faceView) {
        faceView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        [self.captureView addSubview:faceView];
        faceView.hidden = YES;
    }
    CGSize viewBounds = self.captureView.bounds.size;

    [(GPUImageMotionDetector *) filterMotionDetector setMotionDetectionBlock:^(CGPoint motionCentroid, CGFloat motionIntensity, CMTime frameTime) {
        if (motionIntensity > 0.01)
        {
            CGFloat motionBoxWidth = 1500.0 * motionIntensity;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.frame = CGRectMake(round(viewBounds.width * motionCentroid.x - motionBoxWidth / 2.0), round(viewBounds.height * motionCentroid.y - motionBoxWidth / 2.0), motionBoxWidth, motionBoxWidth);
                faceView.hidden = NO;
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.hidden = YES;
            });
        }
        
    }];
    
    [_stillCameraFilter addTarget:filterMotionDetector];
}


- (IBAction)sliderValueChanged:(UISlider *)sender {

    [self addFilterForCaptureStillCameraWith:[_filterManager filterCameraTypeWithFilterType:FilterTypeCrop andValue:(10 - sender.value)]];
}

- (void)sliderFilterValueChange:(float)value;
{
    _currentParentFilterObject.indexValue = value;
    self.filterValue.text = [NSString stringWithFormat:@"%1.0f", value];
    
    switch (_currentParentFilterObject.filterMode) {
        case CameraSetting:
        {
            if (_currentParentFilterObject.cameraType == FilterTypeMotionDetector) {
                if (!filterMotionDetector) {
                    filterMotionDetector = [[GPUImageMotionDetector alloc] init];
                }
                
                [(GPUImageMotionDetector *)filterMotionDetector setLowPassFilterStrength:value/10];
                [self motionDetectFilter];
                return;
            }
            
            [self addFilterForCaptureStillCameraWith:[_filterManager filterCameraTypeWithFilterType:_currentParentFilterObject.cameraType andValue:value]];
        }
            break;
        case PhotoSetting:
        {
            if (_currentParentFilterObject.photoType == PhotoJPEGQuanlity) {
                _photoJPEGQuanlity = value * 0.1;
            }
        }
            break;
        case VideoSetting:
        {
            
        }
            break;
        case OtherSetting:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)writeMovieToLibraryWithPath:(NSURL *)path
{
    NSLog(@"writing %@ to library", path);
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:path
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error)
                                    {
                                        NSLog(@"Error saving to library%@", [error localizedDescription]);
                                    } else
                                    {
                                        NSLog(@"SAVED %@ to photo lib",path);
                                    }
                                }];
}

#define kVideoViewHeight 50
#define kBootomViewHeight 85
#define kThumbImgSize 35

#pragma mark -
#pragma mark - Detect Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        
        [self changeUILandscapeRotation];
        
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation)) {

        [self changeUIPortraitRotation];
    }
}

- (void)changeUILandscapeRotation;
{
    NSLog(@"ROTATION: Landscape");
    
    if (_stillCameraFilter) {
        _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationLandscapeRight;
    }
    
    if (_cameraFilter && _isAutoRotationVideo) {
        _cameraFilter.outputImageOrientation = UIInterfaceOrientationLandscapeRight;
    }
    
    maximumItemCount = max_ITEM_COUNT_LANDCAPT;
    
    UIImage *bottomBarPortrait = [UIImage imageNamed:@"buttom_bar_portrain.png"];
    
    float navigaHeight = self.navigationController.navigationBar.frame.size.height;
    if ([self.navigationController.navigationBar isHidden]) {
        navigaHeight = 0;
    }
    
    CGRect screenBound = [self getLandscaptScreenBound]; // [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(screenBound.size.width - kVideoViewHeight - kBootomViewHeight, -navigaHeight, kVideoViewHeight + kBootomViewHeight, screenBound.size.height);
    
    self.controlView.frame = frame;
    self.bottomBarImage.frame = CGRectMake(kVideoViewHeight, 0, kBootomViewHeight, screenBound.size.height);
    self.videoView.frame = CGRectMake(0, 0, kVideoViewHeight + 20, screenBound.size.height);
    self.bottomBarImage.image = bottomBarPortrait;
    
    NSLog(@"width %f", screenBound.size.width);
    NSLog(@"height %f", screenBound.size.height);
    
    // Config element view on bottom bar
    self.captureBtn.frame = CGRectMake(kVideoViewHeight + 10, (screenBound.size.height - self.captureBtn.frame.size.width) / 2 + 3, self.captureBtn.frame.size.width, self.captureBtn.frame.size.height);
    
    self.rectImage.frame = CGRectMake(3,
                                      self.videoView.frame.size.height / 2 - 70
                                      ,self.rectImage.frame.size.width,
                                      self.rectImage.frame.size.height);
    self.timmerLable.frame = CGRectMake(3,
                                        self.videoView.frame.size.height / 2 - 50,
                                        self.timmerLable.frame.size.width,
                                        self.timmerLable.frame.size.height);

    
    self.thumbPhotoImage.frame = CGRectMake(85, screenBound.size.height - (25 + kThumbImgSize), kThumbImgSize, kThumbImgSize);
    
    self.cameraChangeImage.frame = CGRectMake(80, 25, self.cameraChangeImage.frame.size.width, self.cameraChangeImage.frame.size.height);
    
    self.filterView.frame = CGRectMake(self.filterView.frame.origin.x,
                                       self.filterView.frame.origin.y,
                                       screenBound.size.width - 20 - (kThumbImgSize + kVideoViewHeight),
                                       self.filterView.frame.size.height);
    
    [self reloadTableFilter];
    
    _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationLandscapeRight;
}

- (void)changeUIPortraitRotation;
{
    NSLog(@"ROTATION: Portrait");
    
    if (_stillCameraFilter) {
        _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
    }
    
    if (_cameraFilter && _isAutoRotationVideo) {
        _cameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
    }
    
    maximumItemCount = max_ITEM_COUNT;
    
    UIImage *bottomBarLandscape = [UIImage imageNamed:@"buttom_bar.png"];
    
    float navigaHeight = self.navigationController.navigationBar.frame.size.height;
    if ([self.navigationController.navigationBar isHidden]) {
        navigaHeight = 0;
    }
    
    CGRect screenBound = [self getPortraitScreenBound]; //[[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, screenBound.size.height - kVideoViewHeight - kBootomViewHeight - navigaHeight, screenBound.size.width, kVideoViewHeight + kBootomViewHeight);
    
    self.controlView.frame = frame;
    self.bottomBarImage.frame = CGRectMake(0, kVideoViewHeight, screenBound.size.width, kBootomViewHeight);
    self.videoView.frame = CGRectMake(0, 0, screenBound.size.width, kVideoViewHeight + 20);
    self.bottomBarImage.image = bottomBarLandscape;
    
    // Config element view on bottom bar
    self.captureBtn.frame = CGRectMake((screenBound.size.width - self.captureBtn.frame.size.width) / 2 - 3, kVideoViewHeight + 10, self.captureBtn.frame.size.width, self.captureBtn.frame.size.height);
    
    self.rectImage.frame = CGRectMake((screenBound.size.width - 180) / 2,
                                      self.videoView.frame.size.height / 2 - 10
                                      ,self.rectImage.frame.size.width,
                                      self.rectImage.frame.size.height);
    self.timmerLable.frame = CGRectMake(self.rectImage.frame.origin.x + self.rectImage.frame.size.width + 10,
                                        self.videoView.frame.size.height / 2 - 15,
                                        self.timmerLable.frame.size.width,
                                        self.timmerLable.frame.size.height);
    
    self.thumbPhotoImage.frame = CGRectMake(25, 85, kThumbImgSize, kThumbImgSize);
    
    self.cameraChangeImage.frame = CGRectMake(screenBound.size.width - (25 + kThumbImgSize), 80, self.cameraChangeImage.frame.size.width, self.cameraChangeImage.frame.size.height);
    
    self.filterView.frame = CGRectMake(self.filterView.frame.origin.x,
                                       self.filterView.frame.origin.y,
                                       screenBound.size.width - 40,
                                       self.filterView.frame.size.height);
    
    [self reloadTableFilter];
    
    _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
}



- (CGRect)getPortraitScreenBound;
{
    CGRect screenBoundReal;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    if (screenBound.size.width > screenBound.size.height) {
        screenBoundReal.size.height = screenBound.size.width;
        screenBoundReal.size.width = screenBound.size.height;
    } else {
        screenBoundReal.size.height = screenBound.size.height;
        screenBoundReal.size.width = screenBound.size.width;
    }
    
    return screenBoundReal;
}

- (CGRect)getLandscaptScreenBound;
{
    CGRect screenBoundReal;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    if (screenBound.size.width < screenBound.size.height) {
        screenBoundReal.size.height = screenBound.size.width;
        screenBoundReal.size.width = screenBound.size.height;
    } else {
        screenBoundReal.size.height = screenBound.size.height;
        screenBoundReal.size.width = screenBound.size.width;
    }
    
    return screenBoundReal;
}

-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:17];
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor redColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
