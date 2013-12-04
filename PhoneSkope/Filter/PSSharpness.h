
#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSSharpness : NSObject

-(NSArray*)getArray;
-(GPUImageSharpenFilter*)getSharpness:(int)value;
-(GPUImageSharpenFilter*)getDefaultValue;

@end
