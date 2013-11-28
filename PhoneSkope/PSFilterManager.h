

#import <Foundation/Foundation.h>
#import "PSFilterObject.h"
#import "PSWhiteBalance.h"
#import "PSSceneMode.h"
#import "PSExposureMode.h"
#import "PSExposureCompensation.h"
#import "PSFocusMode.h"
#import "PSBrightness.h"
#import "PSContrast.h"
#import "PSSaturation.h"
#import "PSSharpness.h"
#import "PSRGB.h"
#import "PSTransform_2D.h"
#import "PSTransform_3D.h"
#import "PSCrop.h"
#import "PSMotionDetector.h"
#import "PSFaceDetection.h"

@interface PSFilterManager : NSObject

@property(nonatomic,strong) NSArray *arrayCameraSetting;
@property(nonatomic,strong) NSArray *arrayVideoSetting;
@property(nonatomic,strong) NSArray *arrayPhotoSetting;
@property(nonatomic,strong) NSArray *arrayOthersSetting;

-(NSArray*)getMenuArray:(CameraFilterType)type;
-(NSArray*)getMenuVideoArray:(VideoFilterType)type;
-(NSArray*)getMenuPhotoArray:(PhotoFilterType)type;
-(NSArray*)getMenuOtherArray:(OthersFilterType)type;

@end
