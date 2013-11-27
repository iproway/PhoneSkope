//
//  PSSharpness.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSSharpness.h"

@implementation PSSharpness
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(GPUImageSharpenFilter*)getSharpness:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageSharpenFilter alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageSharpenFilter *)filter setSharpness:-1];
            break;
        case 1:
            [(GPUImageSharpenFilter *)filter setSharpness:-0.15];
            break;
        case 2:
            [(GPUImageSharpenFilter *)filter setSharpness:0.7];
            break;
        case 3:
            [(GPUImageSharpenFilter *)filter setSharpness:1.5];
            break;
        case 4:
            [(GPUImageSharpenFilter *)filter setSharpness:2.3];
            break;
        case 5:
            [(GPUImageSharpenFilter *)filter setSharpness:3.1];
            break;
        case 6:
            [(GPUImageSharpenFilter *)filter setSharpness:4];
            break;
        default:
            break;
    }
    
    return (GPUImageSharpenFilter*)filter;
}
-(GPUImageSharpenFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageSharpenFilter alloc] init];
    [(GPUImageSharpenFilter *)filter setSharpness:0.0];
    return (GPUImageSharpenFilter*)filter;
}
@end
