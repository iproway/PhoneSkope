

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSExposureMode : NSObject

-(NSArray*)getArray;
-(GPUImageExposureFilter*)getExposureMode:(int)value;
-(GPUImageExposureFilter*)getDefaultValue;

@end
