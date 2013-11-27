//
//  PSTransform_3D.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSTransform_3D.h"

@implementation PSTransform_3D
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", nil];
}
-(GPUImageTransformFilter*)getTransform_3D:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageTransformFilter alloc] init];
    filter = [[GPUImageTransformFilter alloc] init];
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    
    switch (value) {
        case 0:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.0, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 1:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.4, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 2:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.75, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 3:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 1.2, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 4:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 1.6, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 5:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 2.0, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 6:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 2.4, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 7:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 2.8, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 8:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 3.2, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 9:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 3.6, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 10:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 4.0, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 11:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 4.4, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 12:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 4.8, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 13:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 5.2, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 14:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 5.6, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 15:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 6.0, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
            break;
        case 16:
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 6.28, 0.0, 1.0, 0.0);
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
        default:
            break;
    }
    
    return (GPUImageTransformFilter*)filter;
}
-(GPUImageTransformFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageTransformFilter alloc] init];
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 0.4;
    perspectiveTransform.m33 = 0.4;
    perspectiveTransform = CATransform3DScale(perspectiveTransform, 0, 0, 0);
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.0, 0.0, 1.0, 0.0);
    [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
    return (GPUImageTransformFilter*)filter;
}
@end
