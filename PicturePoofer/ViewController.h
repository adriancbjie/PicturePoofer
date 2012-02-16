//
//  ViewController.h
//  PicturePoofer
//
//  Created by Adrian Cheng Bing Jie on 8/2/12.
//  Copyright (c) 2012 adriancbjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIButton *applyEffectButton;

-(IBAction) appleEffect:(id)sender;

@end
