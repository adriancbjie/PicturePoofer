//
//  AdriansFilter.h
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 19/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdriansFilter : NSObject


/**
 * to be documented
 */
+(unsigned char *) applyLomoEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

+(unsigned char *) applyContrastValue:(float)val onData:(unsigned char *)rawData withImageSize:(CGSize) size;

+(unsigned char *) applyBiasValue:(float)val
                           onData:(unsigned char *)rawData
                    withImageSize:(CGSize) size;

+(unsigned char *) applyTintWithMinRGB:(NSArray*)minRGB
                            withMaxRGB:(NSArray*)maxRGB
                                onData:(unsigned char *) rawData
                         withImageSize:(CGSize)size;

+(unsigned char *) convoluteWithKernel:(NSArray*)kernel
                                onData:(unsigned char *) rawData
                         withImageSize:(CGSize)size;

/**
 * to be documented
 */
+(unsigned char *) applyGreyScaleEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

@end
