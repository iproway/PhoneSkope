

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSMotionDetector : NSObject
{
    CIDetector *faceDetector;
    UIView *faceView;
}
@property(nonatomic,weak) UIView* view;
@property(nonatomic,weak) GPUImageVideoCamera* videoCamera;

-(NSArray*)getArray;
-(GPUImageMotionDetector*)getMotionDetector:(int)value;
-(GPUImageMotionDetector*)getDefaultValue;
-(id)initWithView:(UIView*)v Camera:(GPUImageVideoCamera*)_camera;

@end
