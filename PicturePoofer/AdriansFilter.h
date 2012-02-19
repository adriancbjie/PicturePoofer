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
 * Clamps the intensity level between 0 - 255.
 *
 * @param i The intensity level.
 */
#define safe(i) (MIN(255, MAX(0, i)))

/**
 * to be documented
 */
+(unsigned char *) applyEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

/**
 * to be documented
 */
+(unsigned char *) applyGreyScaleEffect:(unsigned char *) rawData withImageSize:(CGSize)size;

@end
