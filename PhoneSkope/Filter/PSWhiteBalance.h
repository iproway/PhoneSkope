//
//  PSWhiteBalance.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>
typedef enum
{
    WhiteBlanceAuto = 0,
    WhiteBlanceIncandescent = 1,
    WhiteBlanceFluorescent = 2,
    WhiteBlanceDaylight = 3,
    WhiteBlanceCloudyDaylight = 4
}WhiteBlanceType;
@interface PSWhiteBalance : NSObject
-(NSArray*)getArray;
-(GPUImageWhiteBalanceFilter *)getWhiteblance:(WhiteBlanceType)type;
@end
