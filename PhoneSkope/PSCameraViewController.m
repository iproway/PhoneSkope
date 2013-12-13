

#import "PSCameraViewController.h"
#import "PSCustomCell.h"

#define TABLE_HEIGHT 36.0f
#define MAX_ITEM_COUNT 8

@interface PSCameraViewController ()
{
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
    
    NSMutableArray *_currentFilterArray;
    
    FlashLightType _flashLight;
    AVCaptureDevice *flashLight;
    BOOL _isNoFlashLight;
    BOOL faceThinking;
    UIView *faceView;
    int _indexTest;
    GPUImageMotionDetector *filterMotionDetector;
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
    sliderRotation = CGAffineTransformRotate(sliderRotation, (M_PI / 2));
    self.sliderBar.transform = sliderRotation;
    
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

    if (count > MAX_ITEM_COUNT)
    count = MAX_ITEM_COUNT;

    height = count * TABLE_HEIGHT;
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}

-(IBAction) segmentChange:(id)sender;
{
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
            _currentSessionFilter = PhotoSetting;
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
    
    if (count > MAX_ITEM_COUNT)
        count = MAX_ITEM_COUNT;
    
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
    
    if (count > MAX_ITEM_COUNT)
        count = MAX_ITEM_COUNT;
    
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
    
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        
        [self presentModalViewController:picker animated:YES];
    }
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
    
    [sender setEnabled:NO];
    
    [_stillCameraFilter capturePhotoAsJPEGProcessedUpToFilter:_filterGroup withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        
        // Save to assets library
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeImageDataToSavedPhotosAlbum:processedJPEG metadata:_stillCameraFilter.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error2)
         {

             if (error2) {
                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }
			 
             runOnMainQueueWithoutDeadlocking(^{

                 [sender setEnabled:YES];
                 
//                 [_stillCameraFilter startCameraCapture];
             });
         }];
    }];

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
    
    if (count > MAX_ITEM_COUNT)
        count = MAX_ITEM_COUNT;
    
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
        
        if (count > MAX_ITEM_COUNT)
            count = MAX_ITEM_COUNT;
        
        height = count * TABLE_HEIGHT;
        self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                                self.tableViewFilter.frame.size.width, height);
        
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
    [_filteredView setFillMode:kGPUImageFillModeStretch];
    
    // Init filter for still camera
    _stillCameraFilter = [[GPUImageStillCamera alloc] init];
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

    

    
    // Init filter for camera
//    _stillCameraFilter = [[GPUImageVideoCamera alloc]
//                                        initWithSessionPreset:AVCaptureSessionPreset640x480
//                                        cameraPosition:AVCaptureDevicePositionBack];
//    
//    _stillCameraFilter = [[GPUImageStillCamera alloc] init];
//    _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;
//    
//    GPUImageOutput<GPUImageInput> *filteraa = [[GPUImageSketchFilter alloc] init];
//    
//    [_stillCameraFilter addTarget:filteraa];
//    
//    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
//    [filteraa addTarget:filteredVideoView];
//    [self.captureView addSubview:filteredVideoView];
//    
//    [_stillCameraFilter startCameraCapture];

}


#pragma mark -
#pragma mark - ViewController Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
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
    self.captureView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
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
    self.scaledSlider.tvSliderValueChangedBlock = ^(id sender){
        
        float value = [(TVCalibratedSlider *)sender value];
        
        _currentParentFilterObject.indexValue = value;
        self.filterValue.text = [NSString stringWithFormat:@"%1.0f", value];
        
        if (_currentParentFilterObject.cameraType == FilterTypeMotionDetector) {
            if (!filterMotionDetector) {
                filterMotionDetector = [[GPUImageMotionDetector alloc] init];
            }
            
            [(GPUImageMotionDetector *)filterMotionDetector setLowPassFilterStrength:value/10];
            [self motionDetectFilter];
            return;
        }
        
        [self addFilterForCaptureStillCameraWith:[_filterManager filterCameraTypeWithFilterType:_currentParentFilterObject.cameraType andValue:value]];
    };
    
    self.filterValue.layer.cornerRadius = 5.0f;
    self.filterValue.layer.borderWidth = 1.5f;
    self.filterValue.layer.borderColor = [[UIColor blueColor] CGColor];
    
    [self.sliderView setHidden:YES];
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
//                    [_filterManager filterVideoTypeWithFilterType:_currentParentFilterObject.videoType andValue:indexPath.row];
                    break;
                case PhotoSetting:
//                    [_filterManager filterPhotoTypeWithFilterType:_currentParentFilterObject.photoType andValue:indexPath.row];
                    [self addFilterForCaptureStillCameraWith:[_filterManager filterPhotoTypeWithFilterType:_currentParentFilterObject.photoType andValue:indexPath.row]];
                    break;
                case OtherSetting:
//                    [_filterManager filterOtherTypeWithFilterType:_currentParentFilterObject.otherType andValue:indexPath.row];
                    [self addFilterForCaptureStillCameraWith:[_filterManager filterOtherTypeWithFilterType:_currentParentFilterObject.otherType andValue:indexPath.row]];
                    break;
                default:
                    break;
            }
        }
            break;
    }
    
    [self.tableViewFilter reloadData];
    
    if (count > MAX_ITEM_COUNT)
        count = MAX_ITEM_COUNT;

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
    [_stillCameraFilter removeAllTargets];
    
    [_filterGroup addTarget:filterAdded];
    
    [(GPUImageFilterGroup *)_filterGroup setInitialFilters:[NSArray arrayWithObject:_firstFilterInput]];
    [(GPUImageFilterGroup *)_filterGroup setTerminalFilter:filterAdded];
    
    _currentFilterInput = filterAdded;
    
    [_filterGroup prepareForImageCapture];
    
    [_filterGroup addTarget:_filteredView];
    
    [_stillCameraFilter addTarget:_filterGroup];
}

-(void)changeSwitchStatus:(BOOL)status filterData:(PSFilterData *)data atIndex:(int)index;
{
    switch (_currentSessionFilter) {
        case CameraSetting:
        {
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

            break;
        case PhotoSetting:

            break;
        case VideoSetting:

            break;
        case ChildSetting:
            break;
    }
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

@end
