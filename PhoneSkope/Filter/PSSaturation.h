

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSSaturation : NSObject

-(NSArray*)getArray;
-(GPUImageSaturationFilter*)getSaturation:(int)value;
-(GPUImageSaturationFilter*)getDefaultValue;

@end
