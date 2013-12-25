

#import <Foundation/Foundation.h>

typedef enum
{
    CameraSetting,
    VideoSetting,
    PhotoSetting,
    OtherSetting,
    ChildSetting
} FilterMode;

typedef enum
{
    FilterTypeWhiteBlance = 0,
    FilterTypeSceneMode = 1,
    FilterTypeExposureMode = 2,
    FilterTypeExposureCompensation = 3,
    FilterTypeFocusMode = 4,
    FilterTypeBrightness = 5,
    FilterTypeContrast = 6,
    FilterTypeSaturation = 7,
    FilterTypeSharpness = 8,
    FilterTypeRGB = 9,
    FilterTypeTransform_2D = 10,
    FilterTypeTransform_3D = 11,
    FilterTypeCrop = 12,
    FilterTypeMotionDetector = 13,
    FilterTypeFaceDetection = 14
} CameraType;

typedef enum
{
    OthersShowGrid = 0,
    OthersPreviewTime = 1,
//    OthersVibrateButtonPress = 2,
    OthersFormatFileNames = 2,
    OthersFolderSavePhotoVideo = 3
} OtherType;

typedef enum
{
    RotateVideoResolution = 0,
    RotateVideoFileFormat = 1,
    RotateAutoRotateVideo = 2
} VideoType;

typedef enum{
    PhotoResolution = 0,
    PhotoJPEGQuanlity = 1,
    PhotoSaveGPS = 2,
    PhotoOverlay = 3,
    PhotoDelayJPEG  = 4,
    PhotoStabilizer = 5
} PhotoType;

typedef enum
{
    FlashLightAuto = 0,
    FlashLightOff = 1,
    FlashLightOn = 2,
    FlashLightSound = 3
} FlashLightType;

@interface PSFilterData : NSObject

@property(nonatomic,strong) NSString* filterTitle;
@property(nonatomic,assign) int indexValue;
@property(nonatomic,assign) int switchValue;
@property(nonatomic,strong) NSArray* arrayValue;

@property(nonatomic,assign) FilterMode filterMode;

@property(nonatomic,assign) CameraType cameraType;
@property(nonatomic,assign) PhotoType photoType;
@property(nonatomic,assign) VideoType videoType;
@property(nonatomic,assign) OtherType otherType;

@end
