

#import <Foundation/Foundation.h>

typedef enum
{
    CameraSetting,
    VideoSetting,
    PhotoSetting,
    OtherSetting,
    ChildSetting
} CameraMode;

typedef enum
{
    CellManyChoice,
    CellSwithChoice,
    CellCheckChoice,
    CellNone
} CellType;

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
} CameraFilterType;

typedef enum
{
    OthersShowGrid = 0,
    OthersPreviewTime = 1,
    OthersVibrateButtonPress = 2,
    OthersFormatFileNames = 3,
    OthersFolderSavePhotoVideo = 4
} OthersFilterType;

typedef enum
{
    RotateVideoResolution = 0,
    RotateVideoFileFormat = 1,
    RotateAutoRotateVideo = 2
} VideoFilterType;

typedef enum{
    PhotoResolution = 0,
    PhotoJPEGQuanlity = 1,
    PhotoSaveGPS = 2,
    PhotoOverlay = 3,
    PhotoDelayJPEG  = 4,
    PhotoSelfTimer = 5,
    PhotoStabilizer = 6
} PhotoFilterType;


@interface PSFilterObject : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* value;
@property(nonatomic) int currentIndex;
@property(nonatomic) BOOL isChecked;

@property(nonatomic,strong) NSArray* arrayValue;

@property(nonatomic,assign) CameraMode cameraMode;
@property(nonatomic,assign) CellType cellType;

@property(nonatomic,assign) CameraFilterType cameraFilterType;
@property(nonatomic,assign) VideoFilterType videoFilterType;
@property(nonatomic,assign) PhotoFilterType photoFilterType;
@property(nonatomic,assign) OthersFilterType othersFilterType;

@end
