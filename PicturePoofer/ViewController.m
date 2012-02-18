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

-(IBAction) applyEffect:(id)sender{
    //prepare settings for my blank context, then declare the context
    UIGraphicsBeginImageContextWithOptions(imageView.image.size, YES, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef imageRef =  imageView.image.CGImage;
        CGRect frame =  CGRectMake(0,0,imageView.image.size.width,imageView.image.size.height);
    
    CGContextSetAlpha (context,0.5f);
    CGContextSetShadow (context,frame.size,1.0f);
    CGContextSetRGBFillColor (context,1.0f,0.5f,0.5f,1.0f);
                                   

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0f, imageView.image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    

    
    CGContextDrawImage(context,frame,imageRef);

    CGContextRestoreGState(context);

    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //set the imageview with the new image
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
