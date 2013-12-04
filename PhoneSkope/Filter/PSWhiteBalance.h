

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>
typedef enum
{
    WhiteBlanceAuto = 0,
    WhiteBlanceIncandescent = 1,
    WhiteBlanceFluorescent = 2,
    WhiteBlanceDaylight = 3,
    WhiteBlanceCloudyDaylight = 4
} WhiteBlanceType;

@interface PSWhiteBalance : NSObject

-(NSArray*)getArray;
-(GPUImageWhiteBalanceFilter*)getDefaultValue;
-(GPUImageWhiteBalanceFilter *)getWhiteblance:(WhiteBlanceType)type;

@end
