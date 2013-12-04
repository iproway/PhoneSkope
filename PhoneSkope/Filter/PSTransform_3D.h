

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSTransform_3D : NSObject

-(NSArray*)getArray;
-(GPUImageTransformFilter*)getTransform_3D:(int)value;
-(GPUImageTransformFilter*)getDefaultValue;

@end
