

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSFocusMode : NSObject

-(NSArray*)getArray;
-(GPUImageTiltShiftFilter*)getFocusMode:(int)value;
-(GPUImageTiltShiftFilter*)getDefaultValue;

@end
