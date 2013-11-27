//
//  PSTransform_2D.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSTransform_2D.h"

@implementation PSTransform_2D
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", nil];
}
-(GPUImageTransformFilter*)getTransform_2D:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageTransformFilter alloc] init];
    switch (value) {
        case 0:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(0.0)];
            break;
        case 1:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(0.4)];
            break;
        case 2:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(0.8)];
            break;
        case 3:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(1.2)];
            break;
        case 4:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(1.6)];
            break;
        case 5:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
            break;
        case 6:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.4)];
            break;
        case 7:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.8)];
            break;
        case 8:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(3.2)];
            break;
        case 9:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(3.6)];
            break;
        case 10:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(4.0)];
            break;
        case 11:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(4.4)];
            break;
        case 12:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(4.8)];
            break;
        case 13:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(5.2)];
            break;
        case 14:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(5.6)];
            break;
        case 15:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(6.0)];
            break;
        case 16:
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(6.28)];
        default:
            break;
    }
    
    return (GPUImageTransformFilter*)filter;
}
-(GPUImageTransformFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
    return (GPUImageTransformFilter*)filter;
}
@end
