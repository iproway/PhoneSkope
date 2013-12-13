

#import <Foundation/Foundation.h>
#import "PSFilterData.h"
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

@property(nonatomic,strong) GPUImageFilterGroup *filterGroup;

-(NSArray*)getMenuCameraArray:(CameraType)type;
-(NSArray*)getMenuVideoArray:(VideoType)type;
-(NSArray*)getMenuPhotoArray:(PhotoType)type;
-(NSArray*)getMenuOtherArray:(OtherType)type;

-(void)resetFilterGroup;
//-(void)filterCameraTypeWithFilterType:(CameraType)type andValue:(int)value;
//-(void)filterCameraTypeWithFilterType:(CameraType)type andValue:(int)value withStillCamera:(GPUImageStillCamera* )stillCameraFilter;
//-(void)filterPhotoTypeWithFilterType:(PhotoType)type andValue:(int)value;
//-(void)filterVideoTypeWithFilterType:(VideoType)type andValue:(int)value;
//-(void)filterOtherTypeWithFilterType:(OtherType)type andValue:(int)value;

-(void)filterFor:(GPUImageStillCamera*) stillCameraFilter andValue:(int)value;

- (id)initWithView:(UIView *)view;

-(void)addFaceDetectWithFiter:(GPUImageVideoCamera *)camera withView:(UIView *)view;

-(GPUImageOutput<GPUImageInput> *)filterCameraTypeWithFilterType:(CameraType)type andValue:(int)value;
-(GPUImageOutput<GPUImageInput> *)filterPhotoTypeWithFilterType:(PhotoType)type andValue:(int)value;
-(GPUImageOutput<GPUImageInput> *)filterVideoTypeWithFilterType:(VideoType)type andValue:(int)value;
-(GPUImageOutput<GPUImageInput> *)filterOtherTypeWithFilterType:(OtherType)type andValue:(int)value;


@end
