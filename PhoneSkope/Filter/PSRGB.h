
#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSRGB : NSObject

-(NSArray*)getArray;
-(GPUImageRGBFilter*)getRGB:(int)value;
-(GPUImageRGBFilter*)getDefaultValue;

@end
