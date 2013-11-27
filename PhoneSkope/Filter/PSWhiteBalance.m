//
//  PSWhiteBalance.m
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "PSWhiteBalance.h"

@implementation PSWhiteBalance

-(NSArray*)getArray
{
    return [NSArray arrayWithObjects:@"Auto", @"incandescent", @"fluorescent", @"daylight", @"cloudy-daylight", nil];
}
-(GPUImageWhiteBalanceFilter *)getWhiteblance:(WhiteBlanceType)type;
{
    
    GPUImageOutput<GPUImageInput>* filter = [[GPUImageWhiteBalanceFilter alloc] init];
    
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
