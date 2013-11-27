//
//  PSTransform_2D.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSTransform_2D : NSObject
-(NSArray*)getArray;
-(GPUImageTransformFilter*)getTransform_2D:(int)value;
-(GPUImageTransformFilter*)getDefaultValue;
@end
