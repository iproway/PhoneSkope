//
//  PSMotionDetector.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSMotionDetector.h"

@implementation PSMotionDetector
-(id)initWithView:(UIView*)v Camera:(GPUImageVideoCamera*)_camera
{
    self = [super init];
    if (self) {
        self.view = v;
        self.videoCamera = _camera;
    }
    return self;
}

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
}
-(GPUImageMotionDetector*)getMotionDetector:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageMotionDetector alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0];
            break;
        case 1:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.1];
            break;
        case 2:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.2];
            break;
        case 3:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.3];
            break;
        case 4:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.4];
            break;
        case 5:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.5];
            break;
        case 6:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.6];
            break;
        case 7:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.7];
            break;
        case 8:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.8];
            break;
        case 9:
            [(GPUImageMotionDetector *)filter setLowPassFilterStrength:0.9];
            break;
        default:
            break;
    }
    faceView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
    faceView.layer.borderWidth = 1;
    faceView.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:faceView];
    faceView.hidden = YES;
    
    [(GPUImageMotionDetector *) filter setMotionDetectionBlock:^(CGPoint motionCentroid, CGFloat motionIntensity, CMTime frameTime) {
        if (motionIntensity > 0.01)
        {
            CGFloat motionBoxWidth = 1500.0 * motionIntensity;
            CGSize viewBounds = self.view.bounds.size;
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.frame = CGRectMake(round(viewBounds.width * motionCentroid.x - motionBoxWidth / 2.0), round(viewBounds.height * motionCentroid.y - motionBoxWidth / 2.0), motionBoxWidth, motionBoxWidth);
                faceView.hidden = NO;
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.hidden = YES;
            });
        }
        
    }];
    
    return (GPUImageMotionDetector*)filter;
}
-(GPUImageMotionDetector*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageMotionDetector alloc] init];
    faceView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
    faceView.layer.borderWidth = 1;
    faceView.layer.borderColor = [[UIColor redColor] CGColor];
    [self.view addSubview:faceView];
    faceView.hidden = YES;
    
    [(GPUImageMotionDetector *) filter setMotionDetectionBlock:^(CGPoint motionCentroid, CGFloat motionIntensity, CMTime frameTime) {
        if (motionIntensity > 0.01)
        {
            CGFloat motionBoxWidth = 1500.0 * motionIntensity;
            CGSize viewBounds = self.view.bounds.size;
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.frame = CGRectMake(round(viewBounds.width * motionCentroid.x - motionBoxWidth / 2.0), round(viewBounds.height * motionCentroid.y - motionBoxWidth / 2.0), motionBoxWidth, motionBoxWidth);
                faceView.hidden = NO;
            });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                faceView.hidden = YES;
            });
        }
        
    }];
    return (GPUImageMotionDetector*)filter;
}
@end
