

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSContrast : NSObject

-(NSArray*)getArray;
-(GPUImageContrastFilter*)getContrast:(int)value;
-(GPUImageContrastFilter*)getDefaultValue;

@end
