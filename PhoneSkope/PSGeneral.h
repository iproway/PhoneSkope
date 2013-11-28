//
//
//#import <Foundation/Foundation.h>
//#import "PSWhiteBalance.h"
//#import "PSSceneMode.h"
//#import "PSExposureMode.h"
//#import "PSExposureCompensation.h"
//#import "PSFocusMode.h"
//#import "PSBrightness.h"
//#import "PSContrast.h"
//#import "PSSaturation.h"
//#import "PSSharpness.h"
//#import "PSRGB.h"
//#import "PSTransform_2D.h"
//#import "PSTransform_3D.h"
//#import "PSCrop.h"
//#import "PSMotionDetector.h"
//#import "PSFaceDetection.h"
//
//typedef enum
//{
//    FilterTypeWhiteBlance = 0,
//    FilterTypeSceneMode = 1,
//    FilterTypeExposureMode = 2,
//    FilterTypeExposureCompensation = 3,
//    FilterTypeFocusMode = 4,
//    FilterTypeBrightness = 5,
//    FilterTypeContrast = 6,
//    FilterTypeSaturation = 7,
//    FilterTypeSharpness = 8,
//    FilterTypeRGB = 9,
//    FilterTypeTransform_2D = 10,
//    FilterTypeTransform_3D = 11,
//    FilterTypeCrop = 12,
//    FilterTypeMotionDetector = 13,
//    FilterTypeFaceDetection = 14
//}FilterType;
//
//typedef enum
//{
//    RotateVideoResolution = 0,
//    RotateVideoFileFormat = 1,
//    RotateAutoRotateVideo = 2
//}VideoType;
//
//typedef enum
//{
//    OthersShowGrid = 0,
//    OthersPreviewTime = 1,
//    OthersVibrateButtonPress = 2,
//    OthersFormatFileNames = 3,
//    OthersFolderSavePhotoVideo = 4
//}OthersType;
//
//typedef enum
//{
//    CellManyChoice,
//    CellSwithChoice,
//    CellChildElement,
//    CellNone
//}CellType;
//
//typedef enum{
//    PhotoResolution = 0,
//    PhotoJPEGQuanlity = 1,
//    PhotoSaveGPS = 2,
//    PhotoOverlay = 3,
//    PhotoDelayJPEG  = 4,
//    PhotoSelfTimer = 5,
//    PhotoStabilizer = 6
//}PhotoType;
//
//typedef enum
//{
//    SessionCamera,
//    SessionPhoto,
//    SessionOthers,
//    SessionVideo
//}SessionType;
//@interface PSGeneral : NSObject
//{
//    GPUImageOutput<GPUImageInput>* whiteBalanceFilter;
//    GPUImageOutput<GPUImageInput>* sceneModeFilter;
//    GPUImageOutput<GPUImageInput>* exposureModeFilter;
//    GPUImageOutput<GPUImageInput>* exposureCompensationFilter;
//    GPUImageOutput<GPUImageInput>* focusModeFilter;
//    GPUImageOutput<GPUImageInput>* brightnessFilter;
//    GPUImageOutput<GPUImageInput>* contrastFilter;
//    GPUImageOutput<GPUImageInput>* sharpnessFilter;
//    GPUImageOutput<GPUImageInput>* saturationFilter;
//    GPUImageOutput<GPUImageInput>* rgbFilter;
//    GPUImageOutput<GPUImageInput>* transform_2DFilter;
//    GPUImageOutput<GPUImageInput>* transform_3DFilter;
//    GPUImageOutput<GPUImageInput>* cropFilter;
//    GPUImageOutput<GPUImageInput>* montionDetectorFilter;
//    GPUImageOutput<GPUImageInput>* faceDetectorFilter;
//}
//
//@property(nonatomic,strong) GPUImageFilterGroup* currentFilter;
//
//-(id)initWithView:(UIView*)v Camera:(GPUImageVideoCamera *)camera;
//-(id)initWithView:(UIView*)v StillCamera:(GPUImageStillCamera *)camera;
//-(void)setType:(FilterType)type WithValue:(int)value;
//-(NSArray*)getMenuArray:(FilterType)type;
//-(NSArray*)getMenuPhotoArray:(PhotoType)type;
//-(NSArray*)getMenuOtherArray:(OthersType)type;
//-(NSArray*)getMenuVideoArray:(VideoType)type;
//-(NSArray*)getData:(SessionType)type;
//-(void)enableFaceDetection;
//-(void)enableMontionDetector;
//-(void)disableFaceDetection;
//-(void)disableMontionDetector;
//
//@end
