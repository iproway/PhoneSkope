//
//  PSContrast.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSContrast.h"

@implementation PSContrast
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}
-(GPUImageContrastFilter*)getContrast:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageContrastFilter alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageContrastFilter *)filter setContrast:0];
            break;
        case 1:
            [(GPUImageContrastFilter *)filter setContrast:0.75];
            break;
        case 2:
            [(GPUImageContrastFilter *)filter setContrast:1.5];
            break;
        case 3:
            [(GPUImageContrastFilter *)filter setContrast:2];
            break;
        case 4:
            [(GPUImageContrastFilter *)filter setContrast:2.75];
            break;
        case 5:
            [(GPUImageContrastFilter *)filter setContrast:2.5];
            break;
        case 6:
            [(GPUImageContrastFilter *)filter setContrast:4];
            break;
        default:
            break;
    }
    
    return (GPUImageContrastFilter*)filter;
}
-(GPUImageContrastFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageContrastFilter alloc] init];
    [(GPUImageContrastFilter *)filter setContrast:1.0];
    return (GPUImageContrastFilter*)filter;
}
@end
