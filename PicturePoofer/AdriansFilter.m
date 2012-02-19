//
//  AdriansFilter.m
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 19/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import "AdriansFilter.h"

@implementation AdriansFilter

/**
 * Clamps the intensity level between 0 - 255.
 *
 * @param i The intensity level.
 */
#define safe(i) (MIN(255, MAX(0, i)))


#define FBOX(x) [NSNumber numberWithFloat:x]
+ (unsigned char *) applyLomoEffect:(unsigned char *) rawData withImageSize:(CGSize)size;
{
    //first I add a tinted effect to it
    rawData = [AdriansFilter applyTintWithMinRGB:[NSArray arrayWithObjects:FBOX(60.0),FBOX(35.0),FBOX(10.0),nil] 
                                   withMaxRGB:[NSArray arrayWithObjects:FBOX(170.0),FBOX(170.0),FBOX(230.0),nil] 
                                     onData:rawData 
                                withImageSize:size];

    //then I dim down the contrast to 0.8 to give a dull effect
    rawData = [AdriansFilter applyContrastValue:0.8 onData:rawData withImageSize:size];

    //make it darker by a factor of 0.6
    rawData = [AdriansFilter applyBiasValue:0.6 onData:rawData withImageSize:size];


    //try to sharpen it a little
    NSArray *kernel = [NSArray arrayWithObjects: [NSArray arrayWithObjects:FBOX(0.0),FBOX(-0.2),FBOX(0.0),nil],
                                                 [NSArray arrayWithObjects:FBOX(-0.2),FBOX(1.8),FBOX(-0.2),nil],
                                                 [NSArray arrayWithObjects:FBOX(0.0),FBOX(-0.2),FBOX(0.0),nil],
                       nil];
    [AdriansFilter convoluteWithKernel:kernel onData:rawData withImageSize:size];

    //now I'm going to add a vignette to it

    return rawData;

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

#define biasCalc(f,bi) ((1.0 / bi - 1.9) * (0.9 - f) + 1.0)
+(unsigned char *) applyBiasValue:(float)val
                               onData:(unsigned char *)rawData 
                        withImageSize:(CGSize) size
{
    int byteIndex = 0;
    for (int i = 0 ; i< (size.height * size.width) ; ++i)
    {
        rawData[byteIndex] = (char) safe(rawData[byteIndex] * biasCalc(rawData[byteIndex] / 255.0, val));
        rawData[byteIndex+1] = (char) safe(rawData[byteIndex + 1] * biasCalc(rawData[byteIndex + 1] / 255.0, val));;
        rawData[byteIndex+2] = (char) safe(rawData[byteIndex + 2] * biasCalc(rawData[byteIndex + 2] / 255.0, val));;

        byteIndex += 4;
    }
    return rawData;
}

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


+(unsigned char *) convoluteWithKernel:(NSArray*)kernel
                                onData:(unsigned char *) rawData
                         withImageSize:(CGSize)size
{

    int h = size.height;
    int w = size.width;
    int kh = kernel.count / 2;
    int kw = [[kernel objectAtIndex:0] count] / 2;

    for(int i = 0 ; i < size.height ; i++){
        for(int j = 0; j < size.width ; j++){
            int outIndex = (i*w*4) + (j*4);
            float r = 0;
            float g = 0;
            float b = 0;
            for(int n = -kh ; n <= kh ; n++){
                for(int m = -kw; m <= kw ; m++){
                    if(i + n >= 0 && i + n < h){
                        if(j + m >= 0 && j + m < w){
                            float f = [[[kernel objectAtIndex: (n + kh)] objectAtIndex: (m + kw)] floatValue];
                            if (f != 0){
                                int byteIndex = ((i+n)*w*4) + ((j+m)*4);

                                r += rawData[byteIndex] * f;
                                g += rawData[byteIndex + 1] * f;
                                b += rawData[byteIndex + 2] * f;
                            }
                        }
                    }
                }
            }
            rawData[outIndex] = safe(r);
            rawData[outIndex + 1] = safe(g);
            rawData[outIndex + 2] = safe(b);
            rawData[outIndex + 3] = 255;
        }
    }
    return rawData;

}

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
