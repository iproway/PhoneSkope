

#import "PSFocusMode.h"

@interface PSFocusMode()
{
    GPUImageOutput<GPUImageInput>* filter;
}

@end

@implementation PSFocusMode

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6",nil];
}

-(GPUImageTiltShiftFilter*)getFocusMode:(int)value
{
    if (!filter) {
        filter = [[GPUImageTiltShiftFilter alloc] init];
    }
    
    switch (value) {
        case 0:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.1];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.3];
            break;
        case 1:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.2];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.4];
            break;
        case 2:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.3];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.5];
            break;
        case 3:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
            break;
        case 4:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.5];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.7];
            break;
        case 5:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.6];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.8];
            break;
        case 6:
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.7];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.9];
            break;
        default:
            break;
    }
    [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
    return (GPUImageTiltShiftFilter *)filter;
}
-(GPUImageTiltShiftFilter*)getDefaultValue
{
    if (!filter) {
        filter = [[GPUImageTiltShiftFilter alloc] init];
    }
    
    [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
    [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
    [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
    
    return (GPUImageTiltShiftFilter *)filter;
}
@end
