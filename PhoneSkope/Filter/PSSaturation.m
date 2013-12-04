

#import "PSSaturation.h"

@interface PSSaturation()
{
    GPUImageOutput<GPUImageInput>* filter;
}

@end

@implementation PSSaturation

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
}

-(GPUImageSaturationFilter*)getSaturation:(int)value
{
    if (!filter) {
        filter = [[GPUImageSaturationFilter alloc] init];
    }
    
    switch (value) {
        case 0:
            [(GPUImageSaturationFilter *)filter setSaturation:0];
            break;
        case 1:
            [(GPUImageSaturationFilter *)filter setSaturation:0.35];
            break;
        case 2:
            [(GPUImageSaturationFilter *)filter setSaturation:0.7];
            break;
        case 3:
            [(GPUImageSaturationFilter *)filter setSaturation:1];
            break;
        case 4:
            [(GPUImageSaturationFilter *)filter setSaturation:1.35];
            break;
        case 5:
            [(GPUImageSaturationFilter *)filter setSaturation:1.7];
            break;
        case 6:
            [(GPUImageSaturationFilter *)filter setSaturation:2];
            break;
        default:
            break;
    }
    
    return (GPUImageSaturationFilter*)filter;
}

-(GPUImageSaturationFilter*)getDefaultValue
{
    if (!filter) {
        filter = [[GPUImageSaturationFilter alloc] init];
    }
    
    [(GPUImageSaturationFilter *)filter setSaturation:1];
    return (GPUImageSaturationFilter*)filter;
}
@end
