//
//  AdriansFilter.h
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 19/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdriansFilter : NSObject


/** applies custom lomo effect to raw pixel data
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) applyLomoEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

/** adjusts the contrasts to raw pixel data
 @param val - from 0.0 to 1.0 that sets the contasts level
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) applyContrastValue:(float)val onData:(unsigned char *)rawData withImageSize:(CGSize) size;

/** adjusts the darkness level of raw pixel data
 @param val - multiplies the darkness level by factor of this value
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) applyBiasValue:(float)val
                           onData:(unsigned char *)rawData
                    withImageSize:(CGSize) size;

/** applies a tinted color to raw pixel data
 @param minRGB - minimum RGB values
 @param maxRGB - maximum RGB values
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) applyTintWithMinRGB:(NSArray*)minRGB
                            withMaxRGB:(NSArray*)maxRGB
                                onData:(unsigned char *) rawData
                         withImageSize:(CGSize)size;

/** convolves the raw pixel data, used for different purposes achieved by giving it a kernel format. It can do sharpness, blur, and bumps.
 @param kernel - the kernel format in an array
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) convoluteWithKernel:(NSArray*)kernel
                                onData:(unsigned char *) rawData
                         withImageSize:(CGSize)size;

/** a fixed greyscale effet on raw pixel data. This was written to start off my adventure, it's not currently used in lomo.
 @param rawData - the RGBA8 unsigned char * bitmap
 @param size - the size of the image
 @return modified raw pixel data
 */
+(unsigned char *) applyGreyScaleEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

@end
