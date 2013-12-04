

#import "PSWhiteBalance.h"

@interface PSWhiteBalance()
{
    GPUImageOutput<GPUImageInput>* filter;
}

@end

@implementation PSWhiteBalance

- (id)init;
{
    self = [super init];
    if (self) {
        // Initialization code
        filter = [[GPUImageWhiteBalanceFilter alloc] init];
    }
    return self;
}

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"Auto", @"incandescent", @"fluorescent", @"daylight", @"cloudy-daylight", nil];
}

-(GPUImageWhiteBalanceFilter*)getDefaultValue
{
    if (!filter) {
        filter = [[GPUImageWhiteBalanceFilter alloc] init];
    }
    
    [(GPUImageWhiteBalanceFilter *)filter setTemperature:5000];
    return (GPUImageWhiteBalanceFilter *)filter;
}

-(GPUImageWhiteBalanceFilter *)getWhiteblance:(WhiteBlanceType)type;
{
    
    if (!filter) {
        filter = [[GPUImageWhiteBalanceFilter alloc] init];
    }
    
    switch (type) {
        case WhiteBlanceAuto:
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:5000];
            break;
        case WhiteBlanceIncandescent:
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:0];
            break;
        case WhiteBlanceFluorescent:
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:2500];
            break;
        case WhiteBlanceDaylight:
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:7500];
            break;
        case WhiteBlanceCloudyDaylight:
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:10000];
            break;
        default:
            break;
    }
    
    return (GPUImageWhiteBalanceFilter*)filter;
}
@end
