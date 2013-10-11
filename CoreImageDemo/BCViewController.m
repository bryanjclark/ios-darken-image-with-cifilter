//
//  BCViewController.m
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import "BCViewController.h"
#import "UIImage+BlurAndDarken.h"

@interface BCViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *beforeImageView;
@property (nonatomic, strong) IBOutlet UIImageView *afterImageView;

@end

@implementation BCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"testJPG.jpg"];
    
    _beforeImageView.image = image;
    
    _afterImageView.image = [image darkenedAndBlurredImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
