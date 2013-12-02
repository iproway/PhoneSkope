

#import "PSFilterManager.h"

#define DEFAULT_INDEX -1

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
//        motionDetectorObj           = [[PSMotionDetector alloc]init];
//        montionDetectorFilter       = [motionDetectorObj getDefaultValue];
//    }
//    
//    if (isFaceDetectionOpened) {
//        faceDetectionObj            = [[PSFaceDetection alloc]init];
//        faceDetectorFilter          = [faceDetectionObj getFaceDection];
//    }
//    
}

-(NSArray*)getMenuCameraArray:(CameraType)type;
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

-(NSArray*)getMenuVideoArray:(VideoType)type
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

-(NSArray*)getMenuPhotoArray:(PhotoType)type
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
-(NSArray*)getMenuOtherArray:(OtherType)type
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
    [self getDefaultValue];
    
    NSArray *arrCameraSetting = [[NSArray alloc] initWithObjects:
                                 @"White blance",
                                 @"Scene mode",
                                 @"Exposure mode",
                                 @"Exposure compensation",
                                 @"Focus mode",
                                 @"Brightness",
                                 @"Constast",
                                 @"Saturation",
                                 @"Sharpness",
                                 @"RGB",
                                 @"Transform (2D)",
                                 @"Transform (3D)",
                                 @"CROP",
                                 @"Motion Detector",
                                 @"Face Detection", nil];
    
    NSArray *arrVideoSetting = [[NSArray alloc] initWithObjects:
                                @"Video resolution",
                                @"Video file format",
                                @"Auto rotate video", nil];
    
    NSArray *arrPhotoSetting = [[NSArray alloc] initWithObjects:
                                @"Photo resolution",
                                @"JPEG quanlity",
                                @"Save GPS data in EXIF",
                                @"Overlay a time and date",
                                @"HDR",
                                @"Self-timer",
                                @"Image Stabilizer", nil];
    
    NSArray *arrOtherSetting = [[NSArray alloc] initWithObjects:
                                @"Show grid",
                                @"Preview time",
                                @"Vibrate on button press",
                                @"Format of file names",
                                @"Folder to save photo and video", nil];
    
    // Init data for CameraSetting Filter
    if (!self.arrayCameraSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterData *data1 = [[PSFilterData alloc] init];
        [data1 setFilterMode:CameraSetting];
        [data1 setCameraType:FilterTypeWhiteBlance];
        [data1 setFilterTitle:[arrCameraSetting objectAtIndex:data1.cameraType]];
        [data1 setArrayValue:[self getMenuCameraArray:data1.cameraType]];
        [data1 setSwitchValue:DEFAULT_INDEX];
        [data1 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data1];
        
        PSFilterData *data2 = [[PSFilterData alloc] init];
        [data2 setFilterMode:CameraSetting];
        [data2 setCameraType:FilterTypeSceneMode];
        [data2 setFilterTitle:[arrCameraSetting objectAtIndex:data2.cameraType]];
        [data2 setArrayValue:[self getMenuCameraArray:data2.cameraType]];
        [data2 setSwitchValue:DEFAULT_INDEX];
        [data2 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data2];
        
        PSFilterData *data3 = [[PSFilterData alloc] init];
        [data3 setFilterMode:CameraSetting];
        [data3 setCameraType:FilterTypeExposureMode];
        [data3 setFilterTitle:[arrCameraSetting objectAtIndex:data3.cameraType]];
        [data3 setArrayValue:[self getMenuCameraArray:data3.cameraType]];
        [data3 setSwitchValue:DEFAULT_INDEX];
        [data3 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data3];
        
        PSFilterData *data4 = [[PSFilterData alloc] init];
        [data4 setFilterMode:CameraSetting];
        [data4 setCameraType:FilterTypeExposureCompensation];
        [data4 setFilterTitle:[arrCameraSetting objectAtIndex:data4.cameraType]];
        [data4 setArrayValue:[self getMenuCameraArray:data4.cameraType]];
        [data4 setSwitchValue:DEFAULT_INDEX];
        [data4 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data4];
        
        PSFilterData *data5 = [[PSFilterData alloc] init];
        [data5 setFilterMode:CameraSetting];
        [data5 setCameraType:FilterTypeFocusMode];
        [data5 setFilterTitle:[arrCameraSetting objectAtIndex:data5.cameraType]];
        [data5 setArrayValue:[self getMenuCameraArray:data5.cameraType]];
        [data5 setSwitchValue:DEFAULT_INDEX];
        [data5 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data5];
        
        PSFilterData *data6 = [[PSFilterData alloc] init];
        [data6 setFilterMode:CameraSetting];
        [data6 setCameraType:FilterTypeBrightness];
        [data6 setFilterTitle:[arrCameraSetting objectAtIndex:data6.cameraType]];
        [data6 setArrayValue:[self getMenuCameraArray:data6.cameraType]];
        [data6 setSwitchValue:DEFAULT_INDEX];
        [data6 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data6];
        
        PSFilterData *data7 = [[PSFilterData alloc] init];
        [data7 setFilterMode:CameraSetting];
        [data7 setCameraType:FilterTypeContrast];
        [data7 setFilterTitle:[arrCameraSetting objectAtIndex:data7.cameraType]];
        [data7 setArrayValue:[self getMenuCameraArray:data7.cameraType]];
        [data7 setSwitchValue:DEFAULT_INDEX];
        [data7 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data7];
        
        PSFilterData *data8 = [[PSFilterData alloc] init];
        [data8 setFilterMode:CameraSetting];
        [data8 setCameraType:FilterTypeSaturation];
        [data8 setFilterTitle:[arrCameraSetting objectAtIndex:data8.cameraType]];
        [data8 setArrayValue:[self getMenuCameraArray:data8.cameraType]];
        [data8 setSwitchValue:DEFAULT_INDEX];
        [data8 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data8];
        
        PSFilterData *data9 = [[PSFilterData alloc] init];
        [data9 setFilterMode:CameraSetting];
        [data9 setCameraType:FilterTypeSharpness];
        [data9 setFilterTitle:[arrCameraSetting objectAtIndex:data9.cameraType]];
        [data9 setArrayValue:[self getMenuCameraArray:data9.cameraType]];
        [data9 setSwitchValue:DEFAULT_INDEX];
        [data9 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data9];
        
        PSFilterData *data10 = [[PSFilterData alloc] init];
        [data10 setFilterMode:CameraSetting];
        [data10 setCameraType:FilterTypeRGB];
        [data10 setFilterTitle:[arrCameraSetting objectAtIndex:data10.cameraType]];
        [data10 setArrayValue:[self getMenuCameraArray:data10.cameraType]];
        [data10 setSwitchValue:DEFAULT_INDEX];
        [data10 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data10];
        
        PSFilterData *data11 = [[PSFilterData alloc] init];
        [data11 setFilterMode:CameraSetting];
        [data11 setCameraType:FilterTypeTransform_2D];
        [data11 setFilterTitle:[arrCameraSetting objectAtIndex:data11.cameraType]];
        [data11 setArrayValue:[self getMenuCameraArray:data11.cameraType]];
        [data11 setSwitchValue:DEFAULT_INDEX];
        [data11 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data11];
        
        PSFilterData *data12 = [[PSFilterData alloc] init];
        [data12 setFilterMode:CameraSetting];
        [data12 setCameraType:FilterTypeTransform_3D];
        [data12 setFilterTitle:[arrCameraSetting objectAtIndex:data12.cameraType]];
        [data12 setArrayValue:[self getMenuCameraArray:data12.cameraType]];
        [data12 setSwitchValue:DEFAULT_INDEX];
        [data12 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data12];
        
        PSFilterData *data13 = [[PSFilterData alloc] init];
        [data13 setFilterMode:CameraSetting];
        [data13 setCameraType:FilterTypeCrop];
        [data13 setFilterTitle:[arrCameraSetting objectAtIndex:data13.cameraType]];
        [data13 setArrayValue:[self getMenuCameraArray:data13.cameraType]];
        [data13 setSwitchValue:DEFAULT_INDEX];
        [data13 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data13];
        
        PSFilterData *data14 = [[PSFilterData alloc] init];
        [data14 setFilterMode:CameraSetting];
        [data14 setCameraType:FilterTypeMotionDetector];
        [data14 setFilterTitle:[arrCameraSetting objectAtIndex:data14.cameraType]];
        [data14 setArrayValue:[self getMenuCameraArray:data14.cameraType]];
        [data14 setSwitchValue:DEFAULT_INDEX];
        [data14 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data14];
        
        PSFilterData *data15 = [[PSFilterData alloc] init];
        [data15 setFilterMode:CameraSetting];
        [data15 setCameraType:FilterTypeFaceDetection];
        [data15 setFilterTitle:[arrCameraSetting objectAtIndex:data15.cameraType]];
        [data15 setArrayValue:[self getMenuCameraArray:data15.cameraType]];
        [data15 setSwitchValue:0];
        [data15 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data15];
        
        [self setArrayCameraSetting:arrayData];
    }
    

    // Init data for VideoSetting Filter
    if (!self.arrayVideoSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterData *data1 = [[PSFilterData alloc] init];
        [data1 setFilterMode:VideoSetting];
        [data1 setVideoType:RotateVideoResolution];
        [data1 setFilterTitle:[arrVideoSetting objectAtIndex:data1.videoType]];
        [data1 setArrayValue:[self getMenuVideoArray:data1.videoType]];
        [data1 setSwitchValue:DEFAULT_INDEX];
        [data1 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data1];
        
        PSFilterData *data2 = [[PSFilterData alloc] init];
        [data2 setFilterMode:VideoSetting];
        [data2 setVideoType:RotateVideoFileFormat];
        [data2 setFilterTitle:[arrVideoSetting objectAtIndex:data2.videoType]];
        [data2 setArrayValue:[self getMenuVideoArray:data2.videoType]];
        [data2 setSwitchValue:DEFAULT_INDEX];
        [data2 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data2];
        
        PSFilterData *data3 = [[PSFilterData alloc] init];
        [data3 setFilterMode:VideoSetting];
        [data3 setVideoType:RotateAutoRotateVideo];
        [data3 setFilterTitle:[arrVideoSetting objectAtIndex:data3.videoType]];
        [data3 setArrayValue:[self getMenuVideoArray:data3.videoType]];
        [data3 setSwitchValue:0];
        [data3 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data3];
        
        [self setArrayVideoSetting:arrayData];
    }
    
    // Init data for PhotoSetting Filter
    if (!self.arrayPhotoSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterData *data1 = [[PSFilterData alloc] init];
        [data1 setFilterMode:PhotoSetting];
        [data1 setPhotoType:PhotoResolution];
        [data1 setFilterTitle:[arrPhotoSetting objectAtIndex:data1.photoType]];
        [data1 setArrayValue:[self getMenuPhotoArray:data1.photoType]];
        [data1 setSwitchValue:DEFAULT_INDEX];
        [data1 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data1];
        
        PSFilterData *data2 = [[PSFilterData alloc] init];
        [data2 setFilterMode:PhotoSetting];
        [data2 setPhotoType:PhotoJPEGQuanlity];
        [data2 setFilterTitle:[arrPhotoSetting objectAtIndex:data2.photoType]];
        [data2 setArrayValue:[self getMenuPhotoArray:data2.photoType]];
        [data2 setSwitchValue:DEFAULT_INDEX];
        [data2 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data2];
        
        PSFilterData *data3 = [[PSFilterData alloc] init];
        [data3 setFilterMode:PhotoSetting];
        [data3 setPhotoType:PhotoSaveGPS];
        [data3 setFilterTitle:[arrPhotoSetting objectAtIndex:data3.photoType]];
        [data3 setArrayValue:[self getMenuPhotoArray:data3.photoType]];
        [data3 setSwitchValue:0];
        [data3 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data3];
        
        PSFilterData *data4 = [[PSFilterData alloc] init];
        [data4 setFilterMode:PhotoSetting];
        [data4 setPhotoType:PhotoOverlay];
        [data4 setFilterTitle:[arrPhotoSetting objectAtIndex:data4.photoType]];
        [data4 setArrayValue:[self getMenuPhotoArray:data4.photoType]];
        [data4 setSwitchValue:0];
        [data4 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data4];
        
        PSFilterData *data5 = [[PSFilterData alloc] init];
        [data5 setFilterMode:PhotoSetting];
        [data5 setPhotoType:PhotoDelayJPEG];
        [data5 setFilterTitle:[arrPhotoSetting objectAtIndex:data5.photoType]];
        [data5 setArrayValue:[self getMenuPhotoArray:data5.photoType]];
        [data5 setSwitchValue:0];
        [data5 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data5];
        
        PSFilterData *data6 = [[PSFilterData alloc] init];
        [data6 setFilterMode:PhotoSetting];
        [data6 setPhotoType:PhotoSelfTimer];
        [data6 setFilterTitle:[arrPhotoSetting objectAtIndex:data6.photoType]];
        [data6 setArrayValue:[self getMenuPhotoArray:data6.photoType]];
        [data6 setSwitchValue:DEFAULT_INDEX];
        [data6 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data6];
        
        PSFilterData *data7 = [[PSFilterData alloc] init];
        [data7 setFilterMode:PhotoSetting];
        [data7 setPhotoType:PhotoStabilizer];
        [data7 setFilterTitle:[arrPhotoSetting objectAtIndex:data7.photoType]];
        [data7 setArrayValue:[self getMenuPhotoArray:data7.photoType]];
        [data7 setSwitchValue:0];
        [data7 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data7];
        
        [self setArrayPhotoSetting:arrayData];
    }
    
    // Init data for OthersSetting Filter
    if (!self.arrayOthersSetting) {
        NSMutableArray* arrayData = [[NSMutableArray alloc]init];
        
        PSFilterData *data1 = [[PSFilterData alloc] init];
        [data1 setFilterMode:OtherSetting];
        [data1 setOtherType:OthersShowGrid];
        [data1 setFilterTitle:[arrOtherSetting objectAtIndex:data1.otherType]];
        [data1 setArrayValue:[self getMenuOtherArray:data1.otherType]];
        [data1 setSwitchValue:0];
        [data1 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data1];
        
        PSFilterData *data2 = [[PSFilterData alloc] init];
        [data2 setFilterMode:OtherSetting];
        [data2 setOtherType:OthersPreviewTime];
        [data2 setFilterTitle:[arrOtherSetting objectAtIndex:data2.otherType]];
        [data2 setArrayValue:[self getMenuOtherArray:data2.otherType]];
        [data2 setSwitchValue:DEFAULT_INDEX];
        [data2 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data2];
        
        PSFilterData *data3 = [[PSFilterData alloc] init];
        [data3 setFilterMode:OtherSetting];
        [data3 setOtherType:OthersVibrateButtonPress];
        [data3 setFilterTitle:[arrOtherSetting objectAtIndex:data3.otherType]];
        [data3 setArrayValue:[self getMenuOtherArray:data3.otherType]];
        [data3 setSwitchValue:0];
        [data3 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data3];
        
        PSFilterData *data4 = [[PSFilterData alloc] init];
        [data4 setFilterMode:OtherSetting];
        [data4 setOtherType:OthersFormatFileNames];
        [data4 setFilterTitle:[arrOtherSetting objectAtIndex:data4.otherType]];
        [data4 setArrayValue:[self getMenuOtherArray:data4.otherType]];
        [data4 setSwitchValue:DEFAULT_INDEX];
        [data4 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data4];
        
        PSFilterData *data5 = [[PSFilterData alloc] init];
        [data5 setFilterMode:OtherSetting];
        [data5 setOtherType:OthersFolderSavePhotoVideo];
        [data5 setFilterTitle:[arrOtherSetting objectAtIndex:data5.otherType]];
        [data5 setArrayValue:[self getMenuOtherArray:data5.otherType]];
        [data5 setSwitchValue:DEFAULT_INDEX];
        [data5 setIndexValue:DEFAULT_INDEX];
        [arrayData addObject:data5];
        
        [self setArrayOthersSetting:arrayData];
    }
}

@end
