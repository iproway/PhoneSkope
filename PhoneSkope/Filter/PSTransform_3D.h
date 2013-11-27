//
//  PSTransform_3D.h
//  PhoneSkope
//
//  Created by Phu Phan on 11/11/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>

@interface PSTransform_3D : NSObject
-(NSArray*)getArray;
-(GPUImageTransformFilter*)getTransform_3D:(int)value;
-(GPUImageTransformFilter*)getDefaultValue;
@end
