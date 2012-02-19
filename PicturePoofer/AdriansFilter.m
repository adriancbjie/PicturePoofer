//
//  AdriansFilter.m
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 19/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import "AdriansFilter.h"

@implementation AdriansFilter


+ (unsigned char *) applyEffect:(unsigned char *) rawData withImageSize:(CGSize)size;
{
//    int byteIndex = 0;
//    for (int i = 0 ; i< (size.height * size.width) ; ++i)
//    {
//        int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] +
//                           rawData[byteIndex+2]) / 3;
//        
//        rawData[byteIndex] = (char) (outputColor);
//        rawData[byteIndex+1] = (char) (outputColor);
//        rawData[byteIndex+2] = (char) (outputColor);
//        
//        byteIndex += 4;
//    }
//    return rawData;
}

//simple greyscale function with fixed scale of color/3
+(unsigned char *) applyGreyScaleEffect:(unsigned char *) rawData withImageSize:(CGSize)size
{
    int byteIndex = 0;
    for (int i = 0 ; i< (size.height * size.width) ; ++i)
    {
        int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] +
                           rawData[byteIndex+2]) / 3;
        
        rawData[byteIndex] = (char) (outputColor);
        rawData[byteIndex+1] = (char) (outputColor);
        rawData[byteIndex+2] = (char) (outputColor);
        
        byteIndex += 4;
    }
    return rawData;
}


@end
