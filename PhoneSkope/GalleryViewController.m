

#import "GalleryViewController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "ELCAssetTablePicker.h"
#import <QuartzCore/QuartzCore.h>
#import "PSAppDelegate.h"
#define SCALE_SIZE 2.0f


@interface GalleryViewController ()
@property (nonatomic, strong) ALAssetsLibrary *slideLibrary;
@end

@implementation GalleryViewController
@synthesize imageView;
#pragma mark - Circle controller methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.btnDeleteItem.enabled = NO;
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
	elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
    
    
        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteMedia:)];
        [self.navigationItem setRightBarButtonItem:doneButtonItem];
    [self.navigationItem setTitle:@"PhoneSkope"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action controller method
- (IBAction)openGallery:(id)sender {
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
	elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (IBAction)deleteMedia:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Are you sure delete this media?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag = 5;
    [alert show];
}

#pragma mark methods

#pragma mark Zoom and Tap Center Methods
- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
        CGFloat newZoomScale = self.scrollView.zoomScale * SCALE_SIZE;
        newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
        
        // Figure out the rect we want to zoom to, then zoom to it
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat w = scrollViewSize.width / newZoomScale;
        CGFloat h = scrollViewSize.height / newZoomScale;
        CGFloat x = pointInView.x - (w / 2.0f);
        CGFloat y = pointInView.y - (h / 2.0f);
        
        CGRect rectToZoomTo = CGRectMake(x, y, w, h);
        
        [self.scrollView zoomToRect:rectToZoomTo animated:YES];
    }
    else{
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / SCALE_SIZE;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}
#pragma mark process open gallery methods
//open gallery
- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
	ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
	tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}


//finish play video
- (void) videoHasFinishedPlaying:(NSNotification *)paramNotification{
    
    /* Find out what the reason was for the player to stop */
    NSNumber *reason =
    [paramNotification.userInfo
     valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if (reason != nil){
        NSInteger reasonAsInteger = [reason integerValue];
        
        switch (reasonAsInteger){
            case MPMovieFinishReasonPlaybackEnded:{
                /* The movie ended normally */
                break;
            }
            case MPMovieFinishReasonPlaybackError:{
                /* An error happened and the movie ended */
                break;
            }
            case MPMovieFinishReasonUserExited:{
                /* The user exited the player */
                break;
            }
        }
        
        NSLog(@"Finish Reason = %ld", (long)reasonAsInteger);
        [self stopPlayingVideo:nil];
    } /* if (reason != nil){ */
    
}

//stop video
- (void) stopPlayingVideo:(id)paramSender {
    if (moviePlayer != nil){
        
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:MPMoviePlayerPlaybackDidFinishNotification
         object:moviePlayer];
        
        [moviePlayer stop];
        
        if ([moviePlayer.view.superview isEqual:self.view]){
            [moviePlayer.view removeFromSuperview];
        }
    }
    
}

//process show iamge resource
- (void)showImageResource:(NSDictionary *)dict{
    
    CGRect workingFrame = _scrollView.frame;
	workingFrame.origin.x = 0;
    UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.image = image;
    
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = self.imageView.image.size;
    
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];

//    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//    [imageview setContentMode:UIViewContentModeScaleAspectFit];
//    imageview.frame = workingFrame;
//
//    [_scrollView addSubview:imageview];
//
//    workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
//    
////    [_scrollView setPagingEnabled:YES];
//	[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
}

#pragma mark ELCImagePickerControllerDelegate Methods

//select media
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
	
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
	[images addObjectsFromArray:info];
	for (NSDictionary *dict in info) {
        
        NSURL *url =  [dict objectForKey:UIImagePickerControllerMediaURL];
        //chose type resource is video
        if (url) {
            /* Now create a new movie player using the URL */
            moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
            
            if (moviePlayer != nil){
                
                self.btnDeleteItem.enabled = YES;
                
                /* Listen for the notification that the movie player sends us
                 whenever it finishes playing an audio file */
                [[NSNotificationCenter defaultCenter]
                 addObserver:self
                 selector:@selector(videoHasFinishedPlaying:)
                 name:MPMoviePlayerPlaybackDidFinishNotification
                 object:moviePlayer];
                
                
                /* Scale the movie player to fit the aspect ratio */
                moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
                
                /* Let's start playing the video in full screen mode */
                [moviePlayer play];
                
                [_scrollView addSubview:moviePlayer.view];
                
                [moviePlayer setFullscreen:YES
                                  animated:YES];
                
            } else {
                NSLog(@"Failed to instantiate the movie player.");
                
            }
        }
        else{
            self.btnDeleteItem.enabled = YES;
            [self showImageResource:dict];
        }
	}
    
    self.chosenMedias = images;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//cancel didmiss controller
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 5 && buttonIndex == 1) {
        ALAssetsLibrary *lib = [ALAssetsLibrary new];
        [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if(asset.isEditable && [[[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] absoluteString] isEqualToString:[(NSURL *)[[self.chosenMedias objectAtIndex:0] objectForKey:UIImagePickerControllerReferenceURL] absoluteString]]) {
                    [asset setImageData:nil metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^(void){
                            self.imageView.image = nil;
                            NSLog(@"Asset url %@ should be deleted. (Error %@)", assetURL, error);
                            self.btnDeleteItem.enabled = NO;
                            
                            for (UIView *v in [_scrollView subviews]) {
                                [v removeFromSuperview];
                            }
                            
                            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"The media has been delete success." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [alert show];
                            
                            ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
                            elcPicker.maximumImagesCount = 1;
                            elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
                            elcPicker.imagePickerDelegate = self;
                            
                            [self presentViewController:elcPicker animated:YES completion:nil];
                        });
                    }];
                }
            }];
        } failureBlock:^(NSError *error) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[NSString stringWithFormat:@"Failed to delete this media. You don't have permission update this media."] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }];

    }
}
@end
