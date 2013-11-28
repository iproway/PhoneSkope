//
//
//#import "PSGeneral.h"
//#import "PSVideoObject.h"
//@interface PSGeneral()
//{
//    PSWhiteBalance*         whiteBalanceObj;
//    PSSceneMode*            sceneModeObj;
//    PSExposureMode*         exposureModeObj;
//    PSExposureCompensation* exposureCompensationObj;
//    PSFocusMode*            focusModeObj;
//    PSBrightness*           brightnessObj;
//    PSContrast*             contrastObj;
//    PSSaturation*           saturationObj;
//    PSSharpness*            sharpnessObj;
//    PSRGB*                  rgbObj;
//    PSTransform_2D*         transform_2DObj;
//    PSTransform_3D*         transform_3DObj;
//    PSCrop*                 cropObj;
//    PSMotionDetector*       motionDetectorObj;
//    PSFaceDetection*        faceDetectionObj;
//    
//    UIView* _view;
//    GPUImageVideoCamera* _camera;
//    GPUImageStillCamera* _stillCamera;
//    
//    BOOL isFaceDetectionOpened;
//    BOOL isMotionDetectorOpened;
//    BOOL isRotateVideo;
//}
//@end
//@implementation PSGeneral
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}
//
//-(id)initWithView:(UIView*)v Camera:(GPUImageVideoCamera *)camera
//{
//    self = [super init];
//    if (self) {
//        isRotateVideo = YES;
//        _view = v;
//        _camera = camera;
//        isFaceDetectionOpened = NO;
//        isMotionDetectorOpened = NO;
//        
//        [self getDefaultValue];
//        [self setFilter];
//    }
//    return self;
//}
//
//-(id)initWithView:(UIView*)v StillCamera:(GPUImageStillCamera *)camera
//{
//    self = [super init];
//    if (self) {
//        isRotateVideo = NO;
//        _view = v;
//        _stillCamera = camera;
//        isFaceDetectionOpened = NO;
//        isMotionDetectorOpened = NO;
//        
//        [self getDefaultValue];
//        [self setFilter];
//    }
//    return self;
//}
//
//-(void)getDefaultValue
//{
//    whiteBalanceObj             = [[PSWhiteBalance alloc]init];
//    whiteBalanceFilter          = [whiteBalanceObj getWhiteblance:WhiteBlanceAuto];
//    //self.currentFilter          = whiteBalanceFilter;
//    
//    sceneModeObj                = [[PSSceneMode alloc] init];
//    sceneModeFilter             = [sceneModeObj getDefaultValue];
//    
//    exposureModeObj             = [[PSExposureMode alloc]init];
//    exposureModeFilter          = [exposureModeObj getDefaultValue];
//    
//    exposureCompensationObj     = [[PSExposureCompensation alloc]init];
//    exposureCompensationFilter  = [exposureCompensationObj getDefaultValue];
//    
//    focusModeObj                = [[PSFocusMode alloc]init];
//    focusModeFilter             = [focusModeObj getDefaultValue];
//    
//    brightnessObj               = [[PSBrightness alloc]init];
//    brightnessFilter            = [brightnessObj getDefaultValue];
//    
//    contrastObj                 = [[PSContrast alloc]init];
//    contrastFilter              = [contrastObj getDefaultValue];
//    
//    saturationObj               = [[PSSaturation alloc]init];
//    saturationFilter            = [saturationObj getDefaultValue];
//    
//    sharpnessObj                = [[PSSharpness alloc]init];
//    sharpnessFilter             = [sharpnessObj getDefaultValue];
//    
//    rgbObj                      = [[PSRGB alloc]init];
//    rgbFilter                   = [rgbObj getDefaultValue];
//    
//    transform_2DObj             = [[PSTransform_2D alloc]init];
//    transform_2DFilter          = [transform_2DObj getDefaultValue];
//    
//    transform_3DObj             = [[PSTransform_3D alloc]init];
//    transform_3DFilter          = [transform_3DObj getDefaultValue];
//    
//    cropObj                     = [[PSCrop alloc]init];
//    cropFilter                  = [cropObj getDefaultValue];
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
//}
//
//-(void)setType:(FilterType)type WithValue:(int)value
//{
//    switch (type) {
//        case FilterTypeWhiteBlance:
//            whiteBalanceFilter          = [whiteBalanceObj getWhiteblance:value];
//            break;
//        case FilterTypeSceneMode:
//            sceneModeFilter             = [sceneModeObj getRGB:value];
//            break;
//        case FilterTypeExposureMode:
//            exposureModeFilter          = [exposureModeObj getExposureMode:value];
//            break;
//        case FilterTypeExposureCompensation:
//            exposureCompensationFilter  = [exposureCompensationObj getExposureCompensation:value];
//            break;
//        case FilterTypeFocusMode:
//            focusModeFilter             = [focusModeObj getFocusMode:value];
//            break;
//        case FilterTypeBrightness:
//            brightnessFilter            = [brightnessObj getBrightness:value];
//            break;
//        case FilterTypeContrast:
//            contrastFilter              = [contrastObj getContrast:value];
//            break;
//        case FilterTypeSaturation:
//            saturationFilter            = [saturationObj getSaturation:value];
//            break;
//        case FilterTypeSharpness:
//            sharpnessFilter             = [sharpnessObj getSharpness:value];
//            break;
//        case FilterTypeRGB:
//            rgbFilter                   = [rgbObj getRGB:value];
//            break;
//        case FilterTypeTransform_2D:
//            transform_2DFilter          = [transform_2DObj getTransform_2D:value];
//            break;
//        case FilterTypeTransform_3D:
//            transform_3DFilter          = [transform_3DObj getTransform_3D:value];
//            break;
//        case FilterTypeCrop:
//            cropFilter                  = [cropObj getCrop:value];
//            break;
//        case FilterTypeMotionDetector:
//            montionDetectorFilter       = [motionDetectorObj getMotionDetector:value];
//            break;
//        default:
//            whiteBalanceFilter          = [whiteBalanceObj getWhiteblance:value];
//            break;
//    }
//
//    [self setFilter];
//}
//
//-(void)setFilter
//{
////    [montionDetectorFilter addTarget:(GPUImageView*)_view];
////    [_camera addTarget:montionDetectorFilter];
////    [montionDetectorFilter addTarget:(GPUImageView *)_view];
////    [cropFilter addTarget:(GPUImageView*)_view];
////    [_camera addTarget:cropFilter];
//    [whiteBalanceFilter         addTarget: sceneModeFilter];
//    [sceneModeFilter            addTarget: exposureModeFilter];
//    [exposureModeFilter         addTarget: exposureCompensationFilter];
//    [exposureCompensationFilter addTarget: focusModeFilter];
//    [focusModeFilter            addTarget: brightnessFilter];
//    [brightnessFilter           addTarget: contrastFilter];
//    [contrastFilter             addTarget: saturationFilter];
//    [saturationFilter           addTarget: sharpnessFilter];
//    [sharpnessFilter            addTarget: rgbFilter];
//    
//    
//    self.currentFilter = [[GPUImageFilterGroup alloc]init];
//    [self.currentFilter setInitialFilters:[NSArray arrayWithObjects:whiteBalanceFilter,nil]];
//    [self.currentFilter setTerminalFilter:rgbFilter];
//    if (isRotateVideo) {
//        [_camera addTarget:self.currentFilter];
//    }
//    else
//        [_stillCamera addTarget:self.currentFilter];
//    
//    [self.currentFilter addTarget:(GPUImageView*)_view];
////    [transform_2DFilter addTarget:transform_3DFilter];
////    [transform_3DFilter addTarget:(GPUImageView*)_view];
//    
//    
//    
//}
//-(NSArray*)getMenuArray:(FilterType)type
//{
//    switch (type) {
//        case FilterTypeWhiteBlance:
//            return [whiteBalanceObj getArray];
//            break;
//        case FilterTypeSceneMode:
//            return [sceneModeObj getArray];
//            break;
//        case FilterTypeExposureMode:
//            return [exposureModeObj getArray];
//            break;
//        case FilterTypeExposureCompensation:
//            return [exposureCompensationObj getArray];
//            break;
//        case FilterTypeFocusMode:
//            return [focusModeObj getArray];
//            break;
//        case FilterTypeBrightness:
//            return [brightnessObj getArray];
//            break;
//        case FilterTypeContrast:
//            return [contrastObj getArray];
//            break;
//        case FilterTypeSaturation:
//            return [saturationObj getArray];
//            break;
//        case FilterTypeSharpness:
//            return [sharpnessObj getArray];
//            break;
//        case FilterTypeRGB:
//            return [rgbObj getArray];
//            break;
//        case FilterTypeTransform_2D:
//            return [transform_2DObj getArray];
//            break;
//        case FilterTypeTransform_3D:
//            return [transform_3DObj getArray];
//            break;
//        case FilterTypeCrop:
//            return [cropObj getArray];
//            break;
//        case FilterTypeMotionDetector:
//            return [motionDetectorObj getArray];
//            break;
//        case FilterTypeFaceDetection:
//            return [NSArray arrayWithObjects:@"0",nil];
//            break;
//        default:
//            return [whiteBalanceObj getArray];
//            break;
//    }
//}
//-(NSArray*)getMenuPhotoArray:(PhotoType)type
//{
//    switch (type) {
//        case PhotoResolution:
//            return [[NSArray alloc]initWithObjects:@"352x288", @"640x480", @"1280x720", @"1920x1080", nil];
//            break;
//        case PhotoJPEGQuanlity:
//            return [[NSArray alloc]initWithObjects:@"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10", nil];
//            break;
//        case PhotoSaveGPS:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        case PhotoOverlay:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        case PhotoDelayJPEG:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        case PhotoSelfTimer:
//            return [[NSArray alloc]initWithObjects:@"1s", @"2s", @"3s", @"4s", @"5s", nil];
//            break;
//        case PhotoStabilizer:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        default:
//            return [[NSArray alloc]initWithObjects:@"0", nil];
//            break;
//    }
//}
//-(NSArray*)getMenuOtherArray:(OthersType)type
//{
//    switch (type) {
//        case OthersShowGrid:
//            return [[NSArray alloc]initWithObjects:@"0", nil];
//            break;
//        case OthersPreviewTime:
//            return [[NSArray alloc]initWithObjects:@"None", @"1s", @"2s",@"3s", @"4s", @"5s", nil];
//            break;
//        case OthersVibrateButtonPress:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        case OthersFormatFileNames:
//            return [[NSArray alloc]initWithObjects:@" yyyy_MM_DD_HH_mm_ss_mss.*", @" mss_ss_mm_HH_MM_MM_yyyy.*", nil];
//            break;
//        case OthersFolderSavePhotoVideo:
//            return [[NSArray alloc]initWithObjects:@"IMAGExxxxx.*", @"VIDEOxxxxx.*",nil];
//            break;
//        default:
//            return [[NSArray alloc]initWithObjects:@"0", nil];
//            break;
//    }
//}
//-(NSArray*)getMenuVideoArray:(VideoType)type
//{
//    switch (type) {
//        case RotateVideoResolution:
//            return [[NSArray alloc]initWithObjects:@"352x288", @"640x480", @"1280x720", @"1920x1080", nil];
//            break;
//        case RotateVideoFileFormat:
//            return [[NSArray alloc]initWithObjects:@"3GPP", @"MPEG4", nil];
//            break;
//        case RotateAutoRotateVideo:
//            return [[NSArray alloc]initWithObjects:@"0",nil];
//            break;
//        default:
//            return [[NSArray alloc]initWithObjects:@"", nil];
//            break;
//    }
//}
//-(NSArray*)getData:(SessionType)type
//{
//    NSMutableArray* arrayData = [[NSMutableArray alloc]init];
//    if(type == SessionCamera)
//    {
//        PSVideoObject* obj1 = [[PSVideoObject alloc]initWithName:@"White blance" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeWhiteBlance Value:[self getMenuArray:FilterTypeWhiteBlance][0]];
//        [arrayData addObject:obj1];
//        PSVideoObject* obj2 = [[PSVideoObject alloc]initWithName:@"Scene mode" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeSceneMode Value:[self getMenuArray:FilterTypeSceneMode][0]];
//        [arrayData addObject:obj2];
//        PSVideoObject* obj3 = [[PSVideoObject alloc]initWithName:@"Exposure mode" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeExposureMode Value:[self getMenuArray:FilterTypeExposureMode][0]];
//        [arrayData addObject:obj3];
//        PSVideoObject* obj4 = [[PSVideoObject alloc]initWithName:@"Exposure compensation" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeExposureCompensation Value:[self getMenuArray:FilterTypeExposureCompensation][0]];
//        [arrayData addObject:obj4];
//        PSVideoObject* obj5 = [[PSVideoObject alloc]initWithName:@"Focus mode" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeFocusMode Value:[self getMenuArray:FilterTypeFocusMode][0]];
//        [arrayData addObject:obj5];
//        PSVideoObject* obj6 = [[PSVideoObject alloc]initWithName:@"Brightness" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeBrightness Value:[self getMenuArray:FilterTypeBrightness][0]];
//        [arrayData addObject:obj6];
//        PSVideoObject* obj7 = [[PSVideoObject alloc]initWithName:@"Constast" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeContrast Value:[self getMenuArray:FilterTypeContrast][0]];
//        [arrayData addObject:obj7];
//        PSVideoObject* obj8 = [[PSVideoObject alloc]initWithName:@"Saturation" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeSaturation Value:[self getMenuArray:FilterTypeSaturation][0]];
//        [arrayData addObject:obj8];
//        PSVideoObject* obj9 = [[PSVideoObject alloc]initWithName:@"Sharpness" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeSharpness Value:[self getMenuArray:FilterTypeSharpness][0]];
//        [arrayData addObject:obj9];
//        PSVideoObject* obj10 = [[PSVideoObject alloc]initWithName:@"RGB" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeRGB Value:[self getMenuArray:FilterTypeRGB][0]];
//        [arrayData addObject:obj10];
//        PSVideoObject* obj11 = [[PSVideoObject alloc]initWithName:@"Transform (2D)" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeTransform_2D Value:[self getMenuArray:FilterTypeTransform_2D][0]];
//        [arrayData addObject:obj11];
//        PSVideoObject* obj12 = [[PSVideoObject alloc]initWithName:@"Transform (3D)" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeTransform_3D Value:[self getMenuArray:FilterTypeTransform_3D][0]];
//        [arrayData addObject:obj12];
//        PSVideoObject* obj13 = [[PSVideoObject alloc]initWithName:@"CROP" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeCrop Value:[self getMenuArray:FilterTypeCrop][0]];
//        [arrayData addObject:obj13];
//        PSVideoObject* obj14 = [[PSVideoObject alloc]initWithName:@"Motion Detector" CellType:CellManyChoice SessionType:SessionCamera Type:FilterTypeMotionDetector Value:[self getMenuArray:FilterTypeMotionDetector][0]];
//        [arrayData addObject:obj14];
//        PSVideoObject* obj15 = [[PSVideoObject alloc]initWithName:@"Face Detection" CellType:CellSwithChoice SessionType:SessionCamera Type:FilterTypeFaceDetection Value:[self getMenuArray:FilterTypeFaceDetection][0]];
//        [arrayData addObject:obj15];
//    }
//    if(type == SessionOthers)
//    {
//        PSVideoObject* obj1 = [[PSVideoObject alloc]initWithName:@"Show grid" CellType:CellSwithChoice SessionType:SessionOthers Type:OthersShowGrid Value:[self getMenuOtherArray:OthersShowGrid][0]];
//        [arrayData addObject:obj1];
//        PSVideoObject* obj2 = [[PSVideoObject alloc]initWithName:@"Preview time" CellType:CellManyChoice SessionType:SessionOthers Type:OthersPreviewTime Value:[self getMenuOtherArray:OthersPreviewTime][0]];
//        [arrayData addObject:obj2];
//        PSVideoObject* obj3 = [[PSVideoObject alloc]initWithName:@"Vibrate on utton press" CellType:CellSwithChoice SessionType:SessionOthers Type:OthersVibrateButtonPress Value:[self getMenuOtherArray:OthersVibrateButtonPress][0]];
//        [arrayData addObject:obj3];
//        PSVideoObject* obj4 = [[PSVideoObject alloc]initWithName:@"Format of file names" CellType:CellManyChoice SessionType:SessionOthers Type:OthersFormatFileNames Value:[self getMenuOtherArray:OthersFormatFileNames][0]];
//        [arrayData addObject:obj4];
//        PSVideoObject* obj5 = [[PSVideoObject alloc]initWithName:@"Folder to save photo and video" CellType:CellManyChoice SessionType:SessionOthers Type:OthersFolderSavePhotoVideo Value:[self getMenuOtherArray:OthersFolderSavePhotoVideo][0]];
//        [arrayData addObject:obj5];
//    }
//    if(type == SessionPhoto)
//    {
//        PSVideoObject* obj1 = [[PSVideoObject alloc]initWithName:@"Photo resolution" CellType:CellManyChoice SessionType:SessionPhoto Type:PhotoResolution Value:[self getMenuPhotoArray:PhotoResolution][0]];
//        [arrayData addObject:obj1];
//        PSVideoObject* obj2 = [[PSVideoObject alloc]initWithName:@"JPEG quanlity" CellType:CellManyChoice SessionType:SessionPhoto Type:PhotoJPEGQuanlity Value:[self getMenuPhotoArray:PhotoJPEGQuanlity][0]];
//        [arrayData addObject:obj2];
//        PSVideoObject* obj3 = [[PSVideoObject alloc]initWithName:@"Save GPS data in EXIF" CellType:CellSwithChoice SessionType:SessionPhoto Type:PhotoSaveGPS Value:[self getMenuPhotoArray:PhotoSaveGPS][0]];
//        [arrayData addObject:obj3];
//        PSVideoObject* obj4 = [[PSVideoObject alloc]initWithName:@"Overlay a time and date on the photo" CellType:CellSwithChoice SessionType:SessionPhoto Type:PhotoOverlay Value:[self getMenuPhotoArray:PhotoOverlay][0]];
//        [arrayData addObject:obj4];
//        PSVideoObject* obj5 = [[PSVideoObject alloc]initWithName:@"HDR" CellType:CellSwithChoice SessionType:SessionPhoto Type:PhotoDelayJPEG Value:[self getMenuPhotoArray:PhotoDelayJPEG][0]];
//        [arrayData addObject:obj5];
//        PSVideoObject* obj6 = [[PSVideoObject alloc]initWithName:@"Self-timer" CellType:CellManyChoice SessionType:SessionPhoto Type:PhotoSelfTimer Value:[self getMenuPhotoArray:PhotoSelfTimer][0]];
//        [arrayData addObject:obj6];
//        PSVideoObject* obj7 = [[PSVideoObject alloc]initWithName:@"Image Stabilizer" CellType:CellSwithChoice SessionType:SessionPhoto Type:PhotoStabilizer Value:[self getMenuPhotoArray:PhotoStabilizer][0]];
//        [arrayData addObject:obj7];
//    }
//    if(type == SessionVideo)
//    {
//        PSVideoObject* obj1 = [[PSVideoObject alloc]initWithName:@"Video resolution" CellType:CellManyChoice SessionType:SessionVideo Type:RotateVideoResolution Value:[self getMenuVideoArray:RotateVideoResolution][0]];
//        [arrayData addObject:obj1];
//        PSVideoObject* obj2 = [[PSVideoObject alloc]initWithName:@"Video file format" CellType:CellManyChoice SessionType:SessionVideo Type:RotateVideoFileFormat Value:[self getMenuVideoArray:RotateVideoFileFormat][0]];
//        [arrayData addObject:obj2];
//        PSVideoObject* obj3 = [[PSVideoObject alloc]initWithName:@"Auto rotate video" CellType:CellSwithChoice SessionType:SessionVideo Type:RotateAutoRotateVideo Value:[self getMenuVideoArray:RotateAutoRotateVideo][0]];
//        [arrayData addObject:obj3];
//    }
//    return arrayData;
//}
//-(void)enableFaceDetection
//{
//    
//}
//-(void)enableMontionDetector
//{
//    
//}
//-(void)disableFaceDetection
//{
//    
//}
//-(void)disableMontionDetector
//{
//    
//}
//@end
