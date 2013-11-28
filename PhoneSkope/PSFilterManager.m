

#import "PSFilterManager.h"

@interface PSFilterManager()
{
    PSWhiteBalance*         whiteBalanceObj;
    PSSceneMode*            sceneModeObj;
    PSExposureMode*         exposureModeObj;
    PSExposureCompensation* exposureCompensationObj;
    PSFocusMode*            focusModeObj;
    PSBrightness*           brightnessObj;
    PSContrast*             contrastObj;
    PSSaturation*           saturationObj;
    PSSharpness*            sharpnessObj;
    PSRGB*                  rgbObj;
    PSTransform_2D*         transform_2DObj;
    PSTransform_3D*         transform_3DObj;
    PSCrop*                 cropObj;
    PSMotionDetector*       motionDetectorObj;
    PSFaceDetection*        faceDetectionObj;
    
    
    GPUImageOutput<GPUImageInput>* whiteBalanceFilter;
    GPUImageOutput<GPUImageInput>* sceneModeFilter;
    GPUImageOutput<GPUImageInput>* exposureModeFilter;
    GPUImageOutput<GPUImageInput>* exposureCompensationFilter;
    GPUImageOutput<GPUImageInput>* focusModeFilter;
    GPUImageOutput<GPUImageInput>* brightnessFilter;
    GPUImageOutput<GPUImageInput>* contrastFilter;
    GPUImageOutput<GPUImageInput>* sharpnessFilter;
    GPUImageOutput<GPUImageInput>* saturationFilter;
    GPUImageOutput<GPUImageInput>* rgbFilter;
    GPUImageOutput<GPUImageInput>* transform_2DFilter;
    GPUImageOutput<GPUImageInput>* transform_3DFilter;
    GPUImageOutput<GPUImageInput>* cropFilter;
    GPUImageOutput<GPUImageInput>* montionDetectorFilter;
    GPUImageOutput<GPUImageInput>* faceDetectorFilter;
    
    GPUImageTransformFilter *transformFilter;

}

@end

@implementation PSFilterManager

- (id)init
{
    self = [super init];
    if (self) {
        [self getDefaultValue];
        // init data
        [self initDataFilter];
    }
    return self;
}

-(void)getDefaultValue
{
    
    transformFilter = [[GPUImageTransformFilter alloc] init];
    [transformFilter setAffineTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    
    whiteBalanceObj             = [[PSWhiteBalance alloc]init];
    whiteBalanceFilter          = [whiteBalanceObj getDefaultValue];
    
    sceneModeObj                = [[PSSceneMode alloc] init];
    sceneModeFilter             = [sceneModeObj getDefaultValue];
    
    exposureModeObj             = [[PSExposureMode alloc]init];
    exposureModeFilter          = [exposureModeObj getDefaultValue];
    
    exposureCompensationObj     = [[PSExposureCompensation alloc]init];
    exposureCompensationFilter  = [exposureCompensationObj getDefaultValue];
    
    focusModeObj                = [[PSFocusMode alloc]init];
    focusModeFilter             = [focusModeObj getDefaultValue];
    
    brightnessObj               = [[PSBrightness alloc]init];
    brightnessFilter            = [brightnessObj getDefaultValue];
    
    contrastObj                 = [[PSContrast alloc]init];
    contrastFilter              = [contrastObj getDefaultValue];
    
    saturationObj               = [[PSSaturation alloc]init];
    saturationFilter            = [saturationObj getDefaultValue];
    
    sharpnessObj                = [[PSSharpness alloc]init];
    sharpnessFilter             = [sharpnessObj getDefaultValue];
    
    rgbObj                      = [[PSRGB alloc]init];
    rgbFilter                   = [rgbObj getDefaultValue];
    
    transform_2DObj             = [[PSTransform_2D alloc]init];
    transform_2DFilter          = [transform_2DObj getDefaultValue];
    
    transform_3DObj             = [[PSTransform_3D alloc]init];
    transform_3DFilter          = [transform_3DObj getDefaultValue];
    
    cropObj                     = [[PSCrop alloc]init];
    cropFilter                  = [cropObj getDefaultValue];
//    if (isMotionDetectorOpened) {
//        motionDetectorObj           = [[PSMotionDetector alloc]initWithView:_view Camera:_camera];
//        montionDetectorFilter       = [motionDetectorObj getDefaultValue];
//    }
//    
//    if (isFaceDetectionOpened) {
//        faceDetectionObj            = [[PSFaceDetection alloc]initWithView:_view Camera:_camera];
//        faceDetectorFilter          = [faceDetectionObj getFaceDection];
//    }
//    
}

-(NSArray*)getMenuArray:(CameraFilterType)type
{
    switch (type) {
        case FilterTypeWhiteBlance:
            return [whiteBalanceObj getArray];
            break;
        case FilterTypeSceneMode:
            return [sceneModeObj getArray];
            break;
        case FilterTypeExposureMode:
            return [exposureModeObj getArray];
            break;
        case FilterTypeExposureCompensation:
            return [exposureCompensationObj getArray];
            break;
        case FilterTypeFocusMode:
            return [focusModeObj getArray];
            break;
        case FilterTypeBrightness:
            return [brightnessObj getArray];
            break;
        case FilterTypeContrast:
            return [contrastObj getArray];
            break;
        case FilterTypeSaturation:
            return [saturationObj getArray];
            break;
        case FilterTypeSharpness:
            return [sharpnessObj getArray];
            break;
        case FilterTypeRGB:
            return [rgbObj getArray];
            break;
        case FilterTypeTransform_2D:
            return [transform_2DObj getArray];
            break;
        case FilterTypeTransform_3D:
            return [transform_3DObj getArray];
            break;
        case FilterTypeCrop:
            return [cropObj getArray];
            break;
        case FilterTypeMotionDetector:
            return [motionDetectorObj getArray];
            break;
        case FilterTypeFaceDetection:
            return [NSArray arrayWithObjects:@"0",nil];
            break;
        default:
            return [whiteBalanceObj getArray];
            break;
    }
}

-(NSArray*)getMenuVideoArray:(VideoFilterType)type
{
    switch (type) {
        case RotateVideoResolution:
            return [[NSArray alloc]initWithObjects:@"352x288", @"640x480", @"1280x720", @"1920x1080", nil];
            break;
        case RotateVideoFileFormat:
            return [[NSArray alloc]initWithObjects:@"3GPP", @"MPEG4", nil];
            break;
        case RotateAutoRotateVideo:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        default:
            return [[NSArray alloc]initWithObjects:@"", nil];
            break;
    }
}

-(NSArray*)getMenuPhotoArray:(PhotoFilterType)type
{
    switch (type) {
        case PhotoResolution:
            return [[NSArray alloc]initWithObjects:@"352x288", @"640x480", @"1280x720", @"1920x1080", nil];
            break;
        case PhotoJPEGQuanlity:
            return [[NSArray alloc]initWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", nil];
            break;
        case PhotoSaveGPS:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        case PhotoOverlay:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        case PhotoDelayJPEG:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        case PhotoSelfTimer:
            return [[NSArray alloc]initWithObjects:@"1s", @"2s", @"3s", @"4s", @"5s", nil];
            break;
        case PhotoStabilizer:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        default:
            return [[NSArray alloc]initWithObjects:@"0", nil];
            break;
    }
}
-(NSArray*)getMenuOtherArray:(OthersFilterType)type
{
    switch (type) {
        case OthersShowGrid:
            return [[NSArray alloc]initWithObjects:@"0", nil];
            break;
        case OthersPreviewTime:
            return [[NSArray alloc]initWithObjects:@"None", @"1s", @"2s",@"3s", @"4s", @"5s", nil];
            break;
        case OthersVibrateButtonPress:
            return [[NSArray alloc]initWithObjects:@"0",nil];
            break;
        case OthersFormatFileNames:
            return [[NSArray alloc]initWithObjects:@"yy_MM_DD_HH_mm_ss_mss.*", @"mss_ss_mm_HH_MM_MM_yy.*", nil];
            break;
        case OthersFolderSavePhotoVideo:
            return [[NSArray alloc]initWithObjects:@"IMAGExxxxx.*", @"VIDEOxxxxx.*",nil];
            break;
        default:
            return [[NSArray alloc]initWithObjects:@"0", nil];
            break;
    }
}


- (void)initDataFilter;
{
    // Init data for CameraSetting Filter
    if (!self.arrayCameraSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterObject *obj1 = [[PSFilterObject alloc] init];
        [obj1 setCameraMode:CameraSetting];
        [obj1 setCellType:CellManyChoice];
        [obj1 setCameraFilterType:FilterTypeWhiteBlance];
        [obj1 setArrayValue:[self getMenuArray:FilterTypeWhiteBlance]];
        [obj1 setName:@"White blance"];
        [obj1 setCurrentIndex:0];
        [obj1 setValue:@""];
        [obj1 setIsChecked:NO];
        
        [arrayData addObject:obj1];
        
        PSFilterObject *obj2 = [[PSFilterObject alloc] init];
        [obj2 setCameraMode:CameraSetting];
        [obj2 setCellType:CellManyChoice];
        [obj2 setCameraFilterType:FilterTypeSceneMode];
        [obj2 setArrayValue:[self getMenuArray:FilterTypeSceneMode]];
        [obj2 setName:@"Scene mode"];
        [obj2 setCurrentIndex:0];
        [obj2 setValue:@""];
        [obj2 setIsChecked:NO];
        
        [arrayData addObject:obj2];
        
        PSFilterObject *obj3 = [[PSFilterObject alloc] init];
        [obj3 setCameraMode:CameraSetting];
        [obj3 setCellType:CellManyChoice];
        [obj3 setCameraFilterType:FilterTypeExposureMode];
        [obj3 setArrayValue:[self getMenuArray:FilterTypeExposureMode]];
        [obj3 setName:@"Exposure mode"];
        [obj3 setCurrentIndex:0];
        [obj3 setValue:@""];
        [obj3 setIsChecked:NO];
        
        [arrayData addObject:obj3];
        
        PSFilterObject *obj4 = [[PSFilterObject alloc] init];
        [obj4 setCameraMode:CameraSetting];
        [obj4 setCellType:CellManyChoice];
        [obj4 setCameraFilterType:FilterTypeExposureCompensation];
        [obj4 setArrayValue:[self getMenuArray:FilterTypeExposureCompensation]];
        [obj4 setName:@"Exposure compensation"];
        [obj4 setCurrentIndex:0];
        [obj4 setValue:@""];
        [obj4 setIsChecked:NO];
        
        [arrayData addObject:obj4];
        
        PSFilterObject *obj5 = [[PSFilterObject alloc] init];
        [obj5 setCameraMode:CameraSetting];
        [obj5 setCellType:CellManyChoice];
        [obj5 setCameraFilterType:FilterTypeFocusMode];
        [obj5 setArrayValue:[self getMenuArray:FilterTypeFocusMode]];
        [obj5 setName:@"Focus mode"];
        [obj5 setCurrentIndex:0];
        [obj5 setValue:@""];
        [obj5 setIsChecked:NO];
        
        [arrayData addObject:obj5];
        
        PSFilterObject *obj6 = [[PSFilterObject alloc] init];
        [obj6 setCameraMode:CameraSetting];
        [obj6 setCellType:CellManyChoice];
        [obj6 setCameraFilterType:FilterTypeBrightness];
        [obj6 setArrayValue:[self getMenuArray:FilterTypeBrightness]];
        [obj6 setName:@"Brightness"];
        [obj6 setCurrentIndex:0];
        [obj6 setValue:@""];
        [obj6 setIsChecked:NO];
        
        [arrayData addObject:obj6];
        
        PSFilterObject *obj7 = [[PSFilterObject alloc] init];
        [obj7 setCameraMode:CameraSetting];
        [obj7 setCellType:CellManyChoice];
        [obj7 setCameraFilterType:FilterTypeContrast];
        [obj7 setArrayValue:[self getMenuArray:FilterTypeContrast]];
        [obj7 setName:@"Constast"];
        [obj7 setCurrentIndex:0];
        [obj7 setValue:@""];
        [obj7 setIsChecked:NO];
        
        [arrayData addObject:obj7];
        
        PSFilterObject *obj8 = [[PSFilterObject alloc] init];
        [obj8 setCameraMode:CameraSetting];
        [obj8 setCellType:CellManyChoice];
        [obj8 setCameraFilterType:FilterTypeSaturation];
        [obj8 setArrayValue:[self getMenuArray:FilterTypeSaturation]];
        [obj8 setName:@"Saturation"];
        [obj8 setCurrentIndex:0];
        [obj8 setValue:@""];
        [obj8 setIsChecked:NO];
        
        [arrayData addObject:obj8];
        
        PSFilterObject *obj9 = [[PSFilterObject alloc] init];
        [obj9 setCameraMode:CameraSetting];
        [obj9 setCellType:CellManyChoice];
        [obj9 setCameraFilterType:FilterTypeSharpness];
        [obj9 setArrayValue:[self getMenuArray:FilterTypeSharpness]];
        [obj9 setName:@"Sharpness"];
        [obj9 setCurrentIndex:0];
        [obj9 setValue:@""];
        [obj9 setIsChecked:NO];
        
        [arrayData addObject:obj9];
        
        PSFilterObject *obj10 = [[PSFilterObject alloc] init];
        [obj10 setCameraMode:CameraSetting];
        [obj10 setCellType:CellManyChoice];
        [obj10 setCameraFilterType:FilterTypeRGB];
        [obj10 setArrayValue:[self getMenuArray:FilterTypeRGB]];
        [obj10 setName:@"RGB"];
        [obj10 setCurrentIndex:0];
        [obj10 setValue:@""];
        [obj10 setIsChecked:NO];
        
        [arrayData addObject:obj10];
        
        PSFilterObject *obj11 = [[PSFilterObject alloc] init];
        [obj11 setCameraMode:CameraSetting];
        [obj11 setCellType:CellManyChoice];
        [obj11 setCameraFilterType:FilterTypeTransform_2D];
        [obj11 setArrayValue:[self getMenuArray:FilterTypeTransform_2D]];
        [obj11 setName:@"Transform (2D)"];
        [obj11 setCurrentIndex:0];
        [obj11 setValue:@""];
        [obj11 setIsChecked:NO];
        
        [arrayData addObject:obj11];
        
        PSFilterObject *obj12 = [[PSFilterObject alloc] init];
        [obj12 setCameraMode:CameraSetting];
        [obj12 setCellType:CellManyChoice];
        [obj12 setCameraFilterType:FilterTypeTransform_3D];
        [obj12 setArrayValue:[self getMenuArray:FilterTypeTransform_3D]];
        [obj12 setName:@"Transform (3D)"];
        [obj12 setCurrentIndex:0];
        [obj12 setValue:@""];
        [obj12 setIsChecked:NO];
        
        [arrayData addObject:obj12];
        
        PSFilterObject *obj13 = [[PSFilterObject alloc] init];
        [obj13 setCameraMode:CameraSetting];
        [obj13 setCellType:CellManyChoice];
        [obj13 setCameraFilterType:FilterTypeCrop];
        [obj13 setArrayValue:[self getMenuArray:FilterTypeCrop]];
        [obj13 setName:@"CROP"];
        [obj13 setCurrentIndex:0];
        [obj13 setValue:@""];
        [obj13 setIsChecked:NO];
        
        [arrayData addObject:obj13];
        
        PSFilterObject *obj14 = [[PSFilterObject alloc] init];
        [obj14 setCameraMode:CameraSetting];
        [obj14 setCellType:CellManyChoice];
        [obj14 setCameraFilterType:FilterTypeMotionDetector];
        [obj14 setArrayValue:[self getMenuArray:FilterTypeMotionDetector]];
        [obj14 setName:@"Motion Detector"];
        [obj14 setCurrentIndex:0];
        [obj14 setValue:@""];
        [obj14 setIsChecked:NO];
        
        [arrayData addObject:obj14];
        
        PSFilterObject *obj15 = [[PSFilterObject alloc] init];
        [obj15 setCameraMode:CameraSetting];
        [obj15 setCellType:CellSwithChoice];
        [obj15 setCameraFilterType:FilterTypeFaceDetection];
        [obj15 setArrayValue:[self getMenuArray:FilterTypeFaceDetection]];
        [obj15 setName:@"Face Detection"];
        [obj15 setCurrentIndex:0];
        [obj15 setValue:@""];
        [obj15 setIsChecked:NO];
        
        [arrayData addObject:obj15];

        [self setArrayCameraSetting:arrayData];
    }

    // Init data for VideoSetting Filter
    if (!self.arrayVideoSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterObject *obj1 = [[PSFilterObject alloc] init];
        [obj1 setCameraMode:VideoSetting];
        [obj1 setCellType:CellManyChoice];
        [obj1 setVideoFilterType:RotateVideoResolution];
        [obj1 setArrayValue:[self getMenuVideoArray:RotateVideoResolution]];
        [obj1 setName:@"Video resolution"];
        [obj1 setCurrentIndex:0];
        [obj1 setValue:@""];
        [obj1 setIsChecked:NO];
        
        [arrayData addObject:obj1];
        
        PSFilterObject *obj2 = [[PSFilterObject alloc] init];
        [obj2 setCameraMode:VideoSetting];
        [obj2 setCellType:CellManyChoice];
        [obj2 setVideoFilterType:RotateVideoFileFormat];
        [obj2 setArrayValue:[self getMenuVideoArray:RotateVideoFileFormat]];
        [obj2 setName:@"Video file format"];
        [obj2 setCurrentIndex:0];
        [obj2 setValue:@""];
        [obj2 setIsChecked:NO];
        
        [arrayData addObject:obj2];
        
        PSFilterObject *obj3 = [[PSFilterObject alloc] init];
        [obj3 setCameraMode:VideoSetting];
        [obj3 setCellType:CellSwithChoice];
        [obj3 setVideoFilterType:RotateAutoRotateVideo];
        [obj3 setArrayValue:[self getMenuVideoArray:RotateAutoRotateVideo]];
        [obj3 setName:@"Auto rotate video"];
        [obj3 setCurrentIndex:0];
        [obj3 setValue:@""];
        [obj3 setIsChecked:NO];
        
        [arrayData addObject:obj3];
        
        [self setArrayVideoSetting:arrayData];
    }
    
    // Init data for PhotoSetting Filter
    if (!self.arrayPhotoSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterObject *obj1 = [[PSFilterObject alloc] init];
        [obj1 setCameraMode:PhotoSetting];
        [obj1 setCellType:CellManyChoice];
        [obj1 setPhotoFilterType:PhotoResolution];
        [obj1 setArrayValue:[self getMenuPhotoArray:PhotoResolution]];
        [obj1 setName:@"Photo resolution"];
        [obj1 setCurrentIndex:0];
        [obj1 setValue:@""];
        [obj1 setIsChecked:NO];
        
        [arrayData addObject:obj1];
        
        PSFilterObject *obj2 = [[PSFilterObject alloc] init];
        [obj2 setCameraMode:PhotoSetting];
        [obj2 setCellType:CellManyChoice];
        [obj2 setPhotoFilterType:PhotoJPEGQuanlity];
        [obj2 setArrayValue:[self getMenuPhotoArray:PhotoJPEGQuanlity]];
        [obj2 setName:@"JPEG quanlity"];
        [obj2 setCurrentIndex:0];
        [obj2 setValue:@""];
        [obj2 setIsChecked:NO];
        
        [arrayData addObject:obj2];
        
        PSFilterObject *obj3 = [[PSFilterObject alloc] init];
        [obj3 setCameraMode:PhotoSetting];
        [obj3 setCellType:CellSwithChoice];
        [obj3 setPhotoFilterType:PhotoSaveGPS];
        [obj3 setArrayValue:[self getMenuPhotoArray:PhotoSaveGPS]];
        [obj3 setName:@"Save GPS data in EXIF"];
        [obj3 setCurrentIndex:0];
        [obj3 setValue:@""];
        [obj3 setIsChecked:NO];
        
        [arrayData addObject:obj3];
        
        PSFilterObject *obj4 = [[PSFilterObject alloc] init];
        [obj4 setCameraMode:PhotoSetting];
        [obj4 setCellType:CellSwithChoice];
        [obj4 setPhotoFilterType:PhotoOverlay];
        [obj4 setArrayValue:[self getMenuPhotoArray:PhotoOverlay]];
        [obj4 setName:@"Overlay a time and date"];
        [obj4 setCurrentIndex:0];
        [obj4 setValue:@""];
        [obj4 setIsChecked:NO];
        
        [arrayData addObject:obj4];
        
        PSFilterObject *obj5 = [[PSFilterObject alloc] init];
        [obj5 setCameraMode:PhotoSetting];
        [obj5 setCellType:CellSwithChoice];
        [obj5 setPhotoFilterType:PhotoDelayJPEG];
        [obj5 setArrayValue:[self getMenuPhotoArray:PhotoDelayJPEG]];
        [obj5 setName:@"HDR"];
        [obj5 setCurrentIndex:0];
        [obj5 setValue:@""];
        [obj5 setIsChecked:NO];
        
        [arrayData addObject:obj5];
        
        PSFilterObject *obj6 = [[PSFilterObject alloc] init];
        [obj6 setCameraMode:PhotoSetting];
        [obj6 setCellType:CellManyChoice];
        [obj6 setPhotoFilterType:PhotoSelfTimer];
        [obj6 setArrayValue:[self getMenuPhotoArray:PhotoSelfTimer]];
        [obj6 setName:@"Self-timer"];
        [obj6 setCurrentIndex:0];
        [obj6 setValue:@""];
        [obj6 setIsChecked:NO];
        
        [arrayData addObject:obj6];
        
        PSFilterObject *obj7 = [[PSFilterObject alloc] init];
        [obj7 setCameraMode:PhotoSetting];
        [obj7 setCellType:CellSwithChoice];
        [obj7 setPhotoFilterType:PhotoStabilizer];
        [obj7 setArrayValue:[self getMenuPhotoArray:PhotoStabilizer]];
        [obj7 setName:@"Image Stabilizer"];
        [obj7 setCurrentIndex:0];
        [obj7 setValue:@""];
        [obj7 setIsChecked:NO];
        
        [arrayData addObject:obj7];
        
        [self setArrayPhotoSetting:arrayData];
    }
    
    // Init data for OthersSetting Filter
    if (!self.arrayOthersSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterObject *obj1 = [[PSFilterObject alloc] init];
        [obj1 setCameraMode:OtherSetting];
        [obj1 setCellType:CellSwithChoice];
        [obj1 setOthersFilterType:OthersShowGrid];
        [obj1 setArrayValue:[self getMenuOtherArray:OthersShowGrid]];
        [obj1 setName:@"Show grid"];
        [obj1 setCurrentIndex:0];
        [obj1 setValue:@""];
        [obj1 setIsChecked:NO];
        
        [arrayData addObject:obj1];
        
        PSFilterObject *obj2 = [[PSFilterObject alloc] init];
        [obj2 setCameraMode:OtherSetting];
        [obj2 setCellType:CellManyChoice];
        [obj2 setOthersFilterType:OthersPreviewTime];
        [obj2 setArrayValue:[self getMenuOtherArray:OthersPreviewTime]];
        [obj2 setName:@"Preview time"];
        [obj2 setCurrentIndex:0];
        [obj2 setValue:@""];
        [obj2 setIsChecked:NO];
        
        [arrayData addObject:obj2];
        
        PSFilterObject *obj3 = [[PSFilterObject alloc] init];
        [obj3 setCameraMode:OtherSetting];
        [obj3 setCellType:CellSwithChoice];
        [obj3 setOthersFilterType:OthersVibrateButtonPress];
        [obj3 setArrayValue:[self getMenuOtherArray:OthersVibrateButtonPress]];
        [obj3 setName:@"Vibrate on utton press"];
        [obj3 setCurrentIndex:0];
        [obj3 setValue:@""];
        [obj3 setIsChecked:NO];
        
        [arrayData addObject:obj3];
        
        PSFilterObject *obj4 = [[PSFilterObject alloc] init];
        [obj4 setCameraMode:OtherSetting];
        [obj4 setCellType:CellManyChoice];
        [obj4 setOthersFilterType:OthersFormatFileNames];
        [obj4 setArrayValue:[self getMenuOtherArray:OthersFormatFileNames]];
        [obj4 setName:@"Format of file names"];
        [obj4 setCurrentIndex:0];
        [obj4 setValue:@""];
        [obj4 setIsChecked:NO];
        
        [arrayData addObject:obj4];
        
        PSFilterObject *obj5 = [[PSFilterObject alloc] init];
        [obj5 setCameraMode:OtherSetting];
        [obj5 setCellType:CellManyChoice];
        [obj5 setOthersFilterType:OthersFolderSavePhotoVideo];
        [obj5 setArrayValue:[self getMenuOtherArray:OthersFolderSavePhotoVideo]];
        [obj5 setName:@"Folder to save photo and video"];
        [obj5 setCurrentIndex:0];
        [obj5 setValue:@""];
        [obj5 setIsChecked:NO];
        
        [arrayData addObject:obj5];
        
        [self setArrayOthersSetting:arrayData];
    }
}

@end
