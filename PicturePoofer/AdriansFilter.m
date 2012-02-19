//
//  AdriansFilter.m
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 19/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import "AdriansFilter.h"

@implementation AdriansFilter

#define FBOX(x) [NSNumber numberWithFloat:x]
//i'm going to try a lomo effect.
+ (unsigned char *) applyEffect:(unsigned char *) rawData withImageSize:(CGSize)size;
{
    rawData = [AdriansFilter applyTintWithMinRGB:[NSArray arrayWithObjects:FBOX(60.0),FBOX(35.0),FBOX(10.0),nil] 
                                   withMaxRGB:[NSArray arrayWithObjects:FBOX(170.0),FBOX(170.0),FBOX(230.0),nil] 
                                     onData:rawData 
                                withImageSize:size];
    return [AdriansFilter applyContrastValue:0.8 onData:rawData withImageSize:size];

}

#define contrastCalc(f,c) ((f-0.5) * c + 0.5)
+(unsigned char *) applyContrastValue:(float)val 
                               onData:(unsigned char *)rawData 
                        withImageSize:(CGSize) size
{
    int byteIndex = 0;
    for (int i = 0 ; i< (size.height * size.width) ; ++i)
    {
        rawData[byteIndex] = (char) safe(255.0 * contrastCalc(rawData[byteIndex] / 255.0, val));
        rawData[byteIndex+1] = (char) safe(255.0 * contrastCalc(rawData[byteIndex + 1] / 255.0, val));
        rawData[byteIndex+2] = (char) safe(255.0 * contrastCalc(rawData[byteIndex + 2] / 255.0, val));
        
        byteIndex += 4;
    }
    return rawData;
}

//a function that applies all pixels with specified RGB values
+(unsigned char *) applyTintWithMinRGB:(NSArray*)minRGB 
                      withMaxRGB:(NSArray*)maxRGB
                        onData:(unsigned char *) rawData 
                    withImageSize:(CGSize)size 
{
    int byteIndex = 0;
    
    float minR = [[minRGB objectAtIndex:0] floatValue];
    float maxR = [[maxRGB objectAtIndex:0] floatValue];

    float minG = [[minRGB objectAtIndex:1] floatValue];
    float maxG = [[maxRGB objectAtIndex:1] floatValue];
    
    float minB = [[minRGB objectAtIndex:2] floatValue];
    float maxB = [[maxRGB objectAtIndex:2] floatValue];

    for (int i = 0 ; i< (size.height * size.width) ; ++i)
    {
        rawData[byteIndex] = (char) safe((rawData[byteIndex] - minR) * (255.0 / (maxR - minR)));
        rawData[byteIndex+1] = (char) safe((rawData[byteIndex + 1] - minG) * (255.0 / (maxG - minG)));
        rawData[byteIndex+2] = (char) safe((rawData[byteIndex + 2] - minB) * (255.0 / (maxB - minB)));
        
        byteIndex += 4;
    }
    return rawData;
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
