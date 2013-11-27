//
//  PSSceneMode.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSSceneMode.h"

@implementation PSSceneMode
-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"Auto", @"landscape", @"snow", @"beach", @"sunset", @"night", @"portrait", @"backlight", @"sports", @"steadyphoto", @"flowers", @"candlelight", @"fireworks", @"party", @"night-portrait", @"theatre", @"action", nil];
}
-(GPUImageRGBFilter*)getRGB:(int)value
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageRGBFilter alloc] init];
    
    switch (value) {
        case 0:
            [(GPUImageRGBFilter *)filter setRed:0.0];
            break;
        case 1:
            [(GPUImageRGBFilter *)filter setRed:0.5];
            break;
        case 2:
            [(GPUImageRGBFilter *)filter setRed:1.0];
            break;
        case 3:
            [(GPUImageRGBFilter *)filter setRed:1.5];
            break;
        case 4:
            [(GPUImageRGBFilter *)filter setRed:2.0];
            break;
        case 5:
            [(GPUImageRGBFilter *)filter setGreen:0.0];
            break;
        case 6:
            [(GPUImageRGBFilter *)filter setGreen:0.5];
            break;
        case 7:
            [(GPUImageRGBFilter *)filter setGreen:1.0];
            break;
        case 8:
            [(GPUImageRGBFilter *)filter setGreen:1.5];
            break;
        case 9:
            [(GPUImageRGBFilter *)filter setGreen:2.0];
            break;
        case 10:
            [(GPUImageRGBFilter *)filter setBlue:0.0];
            break;
        case 11:
            [(GPUImageRGBFilter *)filter setBlue:0.5];
            break;
        case 12:
            [(GPUImageRGBFilter *)filter setBlue:1.0];
            break;
        case 13:
            [(GPUImageRGBFilter *)filter setBlue:1.5];
            break;
        case 14:
            [(GPUImageRGBFilter *)filter setBlue:2.0];
            break;
        case 15:
            [(GPUImageRGBFilter *)filter setBlue:1.5];
            break;
        case 16:
            [(GPUImageRGBFilter *)filter setBlue:2.0];
            break;
        default:
            break;
    }
    
    return (GPUImageRGBFilter *)filter;
}
-(GPUImageRGBFilter*)getDefaultValue
{
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageRGBFilter alloc] init];
    [(GPUImageRGBFilter *)filter setGreen:1.0];
    return (GPUImageRGBFilter *)filter;
}
@end
