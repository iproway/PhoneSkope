

#import "PSBrightness.h"

@interface PSBrightness()
{
    GPUImageOutput<GPUImageInput>* filter;
}

@end

@implementation PSBrightness

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}

-(GPUImageBrightnessFilter*)getBrightness:(int)value
{
    if (!filter) {
        filter = [[GPUImageBrightnessFilter alloc] init];
    }
    
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
    if (!filter) {
        filter = [[GPUImageBrightnessFilter alloc] init];
    }
    
    [(GPUImageBrightnessFilter *)filter setBrightness:0];
    
    return (GPUImageBrightnessFilter*)filter;
}

@end
