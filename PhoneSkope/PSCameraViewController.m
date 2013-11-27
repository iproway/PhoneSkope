

#import "PSCameraViewController.h"
#import "PSVideoObject.h"
#import "PSCustomCell.h"

#define TABLE_HEIGHT 36.0f

@interface PSCameraViewController ()
{
    SessionType _currentSessionFilter;
    
    NSMutableArray* _arrayCamera;
    NSMutableArray* _arrayPhoto;
    NSMutableArray* _arrayOther;
    NSMutableArray* _arrayVideo;
    
    PSGeneral* _gerenalObject;
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
#pragma mark - Init SegmentControl filter popup

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
    
    _currentSessionFilter = SessionCamera;
    [self.segmentControlFilter setSelectedSegmentIndex:0];
}

-(IBAction) segmentChange:(id)sender;
{
    
    UISegmentedControl * control = sender;
    int selectedIndex = [control selectedSegmentIndex];
    
    switch (selectedIndex) {
        case 0:
            _currentSessionFilter = SessionCamera;
            break;
        case 1:
            _currentSessionFilter = SessionPhoto;
            break;
        case 2:
            _currentSessionFilter = SessionOthers;
            break;
            
        default:
            break;
    }
    
    [self.tableViewFilter reloadData];
    
    int height = 0;
    switch (_currentSessionFilter) {
        case SessionCamera:
            height = _arrayCamera.count * TABLE_HEIGHT;
            break;
        case SessionOthers:
            height = _arrayOther.count * TABLE_HEIGHT;
            break;
        case SessionPhoto:
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
#pragma mark - Init Filter Data

-(void)initListFilterData;
{
    if (!_gerenalObject) {
        _gerenalObject = [[PSGeneral alloc] init];
    }
    
    _arrayCamera = [[NSMutableArray alloc]initWithArray:[_gerenalObject getData:SessionCamera]];
    _arrayPhoto = [[NSMutableArray alloc]initWithArray:[_gerenalObject getData:SessionPhoto]];
    _arrayOther = [[NSMutableArray alloc]initWithArray:[_gerenalObject getData:SessionOthers]];
    _arrayVideo = [[NSMutableArray alloc]initWithArray:[_gerenalObject getData:SessionVideo]];
    
    [self.tableViewFilter reloadData];
}


#pragma mark -
#pragma mark - ViewController Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initSegmentControll];
    
    self.filterView.backgroundColor = [UIColor clearColor];
    [self.tableViewFilter setSeparatorColor:[UIColor colorWithRed:255.0f/255.0f
                                                            green:255.0f/255.0f
                                                             blue:255.0f/255.0f
                                                            alpha:0.4]];
    self.tableViewFilter.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
    
    [self initListFilterData];
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
    NSLog(@"%d", _arrayCamera.count);
    
    switch (_currentSessionFilter) {
        case SessionCamera:
            return _arrayCamera.count;
            break;
        case SessionOthers:
            return _arrayOther.count;
            break;
        case SessionPhoto:
            return _arrayPhoto.count;
            break;
        default:
            return _arrayCamera.count;
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
        cell.switchBtn.arrange = CustomSwitchArrangeONLeftOFFRight;
        cell.switchBtn.onImage = [UIImage imageNamed:@"switchOne_on.png"];
        cell.switchBtn.offImage = [UIImage imageNamed:@"switchOne_off.png"];
        cell.switchBtn.status = CustomSwitchStatusOff;
    }
    
    PSVideoObject* object;
    switch (_currentSessionFilter) {
        case SessionCamera:
            object = [_arrayCamera objectAtIndex:indexPath.row];
            break;
        case SessionOthers:
            object = [_arrayOther objectAtIndex:indexPath.row];
            break;
        case SessionPhoto:
            object = [_arrayPhoto objectAtIndex:indexPath.row];
            break;
        case SessionVideo:
            object = [_arrayVideo objectAtIndex:indexPath.row];
            break;
    }
    
    cell.titleLabel.text = object.name;
    cell.titleLabel.textColor = [UIColor whiteColor];
    
//    cell.delegate = self;
//    cell.type = object.type;
//    cell.name.text = object.name;
//    cell.value = object.value;
//    cell.videoObject = object;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
