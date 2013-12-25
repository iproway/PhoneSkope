

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface GalleryViewController : UIViewController <ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>{
    MPMoviePlayerController *moviePlayer;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) NSArray *chosenMedias;
- (IBAction)openGallery:(id)sender;
- (IBAction)deleteMedia:(id)sender;

@end
