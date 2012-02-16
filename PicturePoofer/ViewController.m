//
//  ViewController.m
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 8/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize imageView, applyEffectButton;

-(IBAction) appleEffect:(id)sender{
    //load the CIImage
    CIImage *beginImage = 
    [CIImage imageWithCGImage:[self.imageView.image CGImage]];
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //declare filter with sepia effect
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" 
                                  keysAndValues: kCIInputImageKey, beginImage, 
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    
    //apply filter
    CGImageRef cgimg = 
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    //set the imageview with the new image
    [imageView setImage:newImg];
    
    CGImageRelease(cgimg);
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
