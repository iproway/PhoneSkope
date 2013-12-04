

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSBrightness : NSObject

-(NSArray*)getArray;
-(GPUImageBrightnessFilter*)getBrightness:(int)value;
-(GPUImageBrightnessFilter*)getDefaultValue;

@end
