

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSExposureCompensation : NSObject

-(NSArray*)getArray;
-(GPUImageExposureFilter*)getExposureCompensation:(int)value;
-(GPUImageExposureFilter*)getDefaultValue;

@end
