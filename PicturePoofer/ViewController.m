//
//  ViewController.m
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 8/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import "ViewController.h"
#import "ImageDataConverter.h"

@implementation ViewController
@synthesize imageView, applyEffectButton;

-(IBAction) applyEffect:(id)sender{
    
    unsigned char *rawData = [ImageDataConverter convertUIImageToBitmapRGBA8:imageView.image];
    

    int byteIndex = 0;
    for (int i = 0 ; i< (imageView.image.size.height * imageView.image.size.width) ; ++i)
    {
        int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] +
                           rawData[byteIndex+2]) / 3;
        
        rawData[byteIndex] = (char) (outputColor);
        rawData[byteIndex+1] = (char) (outputColor);
        rawData[byteIndex+2] = (char) (outputColor);
        
        byteIndex += 4;
    }
    
    UIImage *newImage = [ImageDataConverter convertBitmapRGBA8ToUIImage:rawData 
                                                       withWidth:imageView.image.size.width 
                                                      withHeight:imageView.image.size.height];
    
    [imageView setImage:newImage];

}

//here onwards are automatically generated methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
