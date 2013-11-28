

#import "PSCameraViewController.h"
#import "PSVideoObject.h"
#import "PSCustomCell.h"

#define TABLE_HEIGHT 36.0f

@interface PSCameraViewController ()
{
    CameraMode _currentSessionFilter;
    
    NSArray* _arrayCamera;
    NSArray* _arrayPhoto;
    NSArray* _arrayOther;
    NSArray* _arrayVideo;
    
    NSArray* _arrayFilterChildElement;
    
    PSFilterManager* _filterManager;
    
//    PSGeneral* _gerenalObject;
    BOOL _isChildFilter;
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
    
    
//    self.sliderBar set
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
    
    UIImage *segmentSelected = [[UIImage imageNamed:@"segment_1px_selected.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"segment_1px_no_select.png"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
    
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
    
    [self.tableViewFilter reloadData];
    
    int height = 0;
    switch (_currentSessionFilter) {
        case CameraSetting:
            height = _arrayCamera.count * TABLE_HEIGHT;
            break;
        case OtherSetting:
            height = _arrayOther.count * TABLE_HEIGHT;
            break;
        case PhotoSetting:
            height = _arrayPhoto.count * TABLE_HEIGHT;
            break;
        default:
            height = _arrayCamera.count * TABLE_HEIGHT;
            break;
    }
    
    if (height > self.filterView.frame.size.height)
        height = self.filterView.frame.size.height;
    
    self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                            self.tableViewFilter.frame.size.width, height);
}


#pragma mark -
#pragma mark - IBAction show flash menu

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
}

-(IBAction)actionAlwayFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:YES];
    [self.flNoneBtn setSelected:NO];
    [self.flSoundBtn setSelected:NO];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash.png"]
                   forState:UIControlStateNormal];
}

-(IBAction)actionNoneFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:NO];
    [self.flNoneBtn setSelected:YES];
    [self.flSoundBtn setSelected:NO];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-off.png"]
                   forState:UIControlStateNormal];
}

-(IBAction)actionSoundFlash:(id)sender;
{
    [self.flAutoBtn setSelected:NO];
    [self.flAlwayBtn setSelected:NO];
    [self.flNoneBtn setSelected:NO];
    [self.flSoundBtn setSelected:YES];
    
    [self.flashBtn setImage:[UIImage imageNamed:@"icon-flash-sound.png"]
                   forState:UIControlStateNormal];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return _arrayFilterChildElement.count;
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
    
    PSFilterObject* object;
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
            object = [_arrayFilterChildElement objectAtIndex:indexPath.row];
            break;
    }
    
    [cell setDataForCustomCell:object];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"indexPath.row = %d", indexPath.row);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PSFilterObject* object;
    switch (_currentSessionFilter) {
        case CameraSetting:
            object = [_arrayCamera objectAtIndex:indexPath.row];
            _arrayFilterChildElement = [_filterManager getMenuArray:indexPath.row];
            _currentSessionFilter = ChildSetting;
            break;
        case OtherSetting:
            object = [_arrayOther objectAtIndex:indexPath.row];
            _arrayFilterChildElement = [_filterManager getMenuOtherArray:indexPath.row];
            _currentSessionFilter = ChildSetting;
            break;
        case PhotoSetting:
            object = [_arrayPhoto objectAtIndex:indexPath.row];
            _arrayFilterChildElement = [_filterManager getMenuPhotoArray:indexPath.row];
            _currentSessionFilter = ChildSetting;
            break;
        case VideoSetting:
            object = [_arrayVideo objectAtIndex:indexPath.row];
            _arrayFilterChildElement = [_filterManager getMenuVideoArray:indexPath.row];
            _currentSessionFilter = ChildSetting;
            break;
        case ChildSetting: // TODO
        {
            if (!_arrayFilterChildElement || _arrayFilterChildElement.count < indexPath.row + 1) {
                return;
            }
            
            for (PSFilterObject *obj in _arrayFilterChildElement) {
                [obj setIsChecked:NO];
            }

            object = [_arrayFilterChildElement objectAtIndex:indexPath.row];
            [object setIsChecked:YES];
            [self.tableViewFilter reloadData];
            
            return;
        }
            break;
    }
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:_arrayFilterChildElement.count];
    for (int i = 0; i < _arrayFilterChildElement.count; i++) {
        
        PSFilterObject *obj = [[PSFilterObject alloc] init];
        [obj setCameraMode:ChildSetting];
        [obj setCellType:CellCheckChoice];
        [obj setName:[_arrayFilterChildElement objectAtIndex:i]];
        [obj setValue:@""];
        [obj setIsChecked:NO];
        
        [tmpArr addObject:obj];
    }
    
    _arrayFilterChildElement = tmpArr;
    _currentSessionFilter = ChildSetting;
    
    if (object.cellType != CellSwithChoice) {

        [self.tableViewFilter reloadData];
        
        int height = 0;
        height = _arrayFilterChildElement.count * TABLE_HEIGHT;
        
        if (height > self.filterView.frame.size.height)
            height = self.filterView.frame.size.height;
        
        self.tableViewFilter.frame = CGRectMake(self.tableViewFilter.frame.origin.x, self.tableViewFilter.frame.origin.y,
                                                self.tableViewFilter.frame.size.width, height);
    }
}

@end
