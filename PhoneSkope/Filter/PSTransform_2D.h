

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSTransform_2D : NSObject

-(NSArray*)getArray;
-(GPUImageTransformFilter*)getTransform_2D:(int)value;
-(GPUImageTransformFilter*)getDefaultValue;

@end
