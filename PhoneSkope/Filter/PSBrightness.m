//
//  PSBrightness.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSBrightness.h"

@implementation PSBrightness
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(GPUImageBrightnessFilter*)getBrightness:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageBrightnessFilter alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageBrightnessFilter *)filter setBrightness:-1];
            break;
        case 1:
            [(GPUImageBrightnessFilter *)filter setBrightness:-0.65];
            break;
        case 2:
            [(GPUImageBrightnessFilter *)filter setBrightness:-0.25];
            break;
        case 3:
            [(GPUImageBrightnessFilter *)filter setBrightness:0];
            break;
        case 4:
            [(GPUImageBrightnessFilter *)filter setBrightness:0.25];
            break;
        case 5:
            [(GPUImageBrightnessFilter *)filter setBrightness:0.65];
            break;
        case 6:
            [(GPUImageBrightnessFilter *)filter setBrightness:1];
            break;
        default:
            break;
    }
    
    return (GPUImageBrightnessFilter*)filter;
}
-(GPUImageBrightnessFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageBrightnessFilter alloc] init];
    [(GPUImageBrightnessFilter *)filter setBrightness:0];
    return (GPUImageBrightnessFilter*)filter;
}
@end
