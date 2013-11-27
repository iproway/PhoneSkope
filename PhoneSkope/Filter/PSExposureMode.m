//
//  PSExposureMode.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSExposureMode.h"

@implementation PSExposureMode
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
}
-(GPUImageExposureFilter*)getExposureMode:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageExposureFilter alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageExposureFilter *)filter setExposure:-4.0];
            break;
        case 1:
            [(GPUImageExposureFilter *)filter setExposure:-3.0];
            break;
        case 2:
            [(GPUImageExposureFilter *)filter setExposure:-2.0];
            break;
        case 3:
            [(GPUImageExposureFilter *)filter setExposure:-1.0];
            break;
        case 4:
            [(GPUImageExposureFilter *)filter setExposure:0.0];
            break;
        case 5:
            [(GPUImageExposureFilter *)filter setExposure:1.0];
            break;
        case 6:
            [(GPUImageExposureFilter *)filter setExposure:2.0];
            break;
        case 7:
            [(GPUImageExposureFilter *)filter setExposure:3.0];
            break;
        case 8:
            [(GPUImageExposureFilter *)filter setExposure:4.0];
            break;
        default:
            break;
    }
    
    return (GPUImageExposureFilter*)filter;
}
-(GPUImageExposureFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageExposureFilter alloc] init];
    [(GPUImageExposureFilter *)filter setExposure:0.0];
    return (GPUImageExposureFilter*)filter;
}
@end
