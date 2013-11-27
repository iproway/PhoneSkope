//
//  PSFaceDetection.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSFaceDetection : NSObject<GPUImageVideoCameraDelegate>
{
    BOOL faceThinking;
    CIDetector *faceDetector;
    UIView *faceView;
}

@property(nonatomic,weak) UIView* view;
@property(nonatomic,weak) GPUImageVideoCamera* videoCamera;


-(id)initWithView:(UIView*)v Camera:(GPUImageVideoCamera*)_camera;
-(GPUImageSaturationFilter*)getFaceDection;
@end
