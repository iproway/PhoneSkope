

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
    
    FlashLightType _flashLight;
    AVCaptureDevice *flashLight;
    BOOL _isNoFlashLight;
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
    NSLog(@"backgroundGestureAction");
    self.flashMenu.hidden = YES;
    self.filterView.hidden = YES;
    self.sliderBar.hidden = YES;
    [self.flashBtn setSelected:NO];
    [self.zoomBtn setSelected:NO];
    [self.optionBtn setSelected:NO];
}

- (IBAction)openPhotoGallery:(id)sender;
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)captureAction:(id)sender;
{
    
    [sender setEnabled:NO];
    
    [_stillCameraFilter capturePhotoAsJPEGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedJPEG, NSError *error){
        
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
                 
                 [_stillCameraFilter startCameraCapture];
             });
         }];
    }];

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
        _filterManager = [[PSFilterManager alloc] init];
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
    
    _stillCameraFilter = [[GPUImageStillCamera alloc] init];
    _stillCameraFilter.outputImageOrientation = UIInterfaceOrientationPortrait;

    [_stillCameraFilter addTarget:_filterManager.filterGroup];

    GPUImageView *filteredView = [[GPUImageView alloc] initWithFrame:self.captureView.bounds];
    [self.captureView addSubview:filteredView];

    [_stillCameraFilter addTarget:filteredView];
    [_stillCameraFilter startCameraCapture];
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
    
    // Init gpuimage
    [self initGPUImageToView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            _currentParentFilterObject.indexValue = indexPath.row;
            _currentSessionFilter = _backupFilter;
            count = _backupArray.count;
            
            // Add filter for GPUImage
            switch (_currentSessionFilter) {
                case CameraSetting:
                    [_filterManager filterCameraTypeWithFilterType:_currentParentFilterObject.cameraType andValue:indexPath.row];
                    break;
                case VideoSetting:
                    [_filterManager filterVideoTypeWithFilterType:_currentParentFilterObject.videoType andValue:indexPath.row];
                    break;
                case PhotoSetting:
                    [_filterManager filterPhotoTypeWithFilterType:_currentParentFilterObject.photoType andValue:indexPath.row];
                    break;
                case OtherSetting:
                    [_filterManager filterOtherTypeWithFilterType:_currentParentFilterObject.otherType andValue:indexPath.row];
                    break;
                default:
                    break;
            }
            
            [_stillCameraFilter removeTarget:_filterManager.filterGroup];
            [_stillCameraFilter addTarget:_filterManager.filterGroup];
            
            
//            [_filterManager filterFor:_stillCameraFilter andValue:indexPath.row];
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

@end
