

#import "PSCrop.h"

@interface PSCrop()
{
    GPUImageOutput<GPUImageInput>* filter;
}

@end

@implementation PSCrop

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", nil];
}
-(GPUImageCropFilter*)getCrop:(int)value
{
    if (!filter) {
        filter = [[GPUImageCropFilter alloc] init];
    }
    
    switch (value) {
        case 0:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.2)];
            break;
        case 1:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.35)];
            break;
        case 2:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.5)];
            break;
        case 3:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.65)];
            break;
        case 4:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.8)];
            break;
        case 5:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.9)];
            break;
        case 6:
            [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, 1.0)];
            break;
        default:
            break;
    }
    return (GPUImageCropFilter*)filter;
}
-(GPUImageCropFilter*)getDefaultValue
{
    return [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
}
@end
