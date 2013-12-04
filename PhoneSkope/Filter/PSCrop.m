

#import "PSCrop.h"

@interface PSCrop()
{
    
}

@end

@implementation PSCrop

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", nil];
}
-(GPUImageCropFilter*)getCrop:(int)value
{
    GPUImageOutput<GPUImageInput>* filter;
    switch (value) {
        case 0:
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.2)];
            break;
        case 1:
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.4)];
            break;
        case 2:
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.6)];
            break;
        case 3:
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.8)];
            break;
        case 4:
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 1.0)];
            break;
        default:
            break;
    }
    return (GPUImageCropFilter*)filter;
}
-(GPUImageCropFilter*)getDefaultValue
{
    return [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 1.0)];
}
@end
