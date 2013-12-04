

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSSceneMode : NSObject

-(NSArray*)getArray;
-(GPUImageRGBFilter*)getRGB:(int)value;
-(GPUImageRGBFilter*)getDefaultValue;

@end
