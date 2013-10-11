//
//  UIImage+BlurAndDarken.m
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import "UIImage+BlurAndDarken.h"

@implementation UIImage (BlurAndDarken)

-(instancetype)darkened:(CGFloat)alpha andBlurredImage:(CGFloat)radius blendModeFilterName:(NSString *)blendModeFilterName {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //First, create some darkness
    CIFilter* blackGenerator = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    CIColor* black = [CIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha];
    [blackGenerator setValue:black forKey:@"inputColor"];
    CIImage* blackImage = [blackGenerator valueForKey:@"outputImage"];
    
    //Second, apply that black
    CIFilter *compositeFilter = [CIFilter filterWithName:blendModeFilterName];
    [compositeFilter setValue:blackImage forKey:@"inputImage"];
    [compositeFilter setValue:inputImage forKey:@"inputBackgroundImage"];
    CIImage *darkenedImage = [compositeFilter outputImage];
    
    //Third, blur the image
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:@(radius) forKey:@"inputRadius"];
    [blurFilter setValue:darkenedImage forKey:kCIInputImageKey];
    CIImage *blurredImage = [blurFilter outputImage];
    
    CGImageRef cgimg = [context createCGImage:blurredImage fromRect:inputImage.extent];
    UIImage *blurredAndDarkenedImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    return blurredAndDarkenedImage;
}

-(instancetype)darkened:(CGFloat)alpha andBlurredImage:(CGFloat)radius {
    return [self darkened:alpha andBlurredImage:radius blendModeFilterName:@"CIMultiplyBlendMode"];
}

-(instancetype)darkenedAndBlurredImage {
    return [self darkened:0.5f andBlurredImage:12.0f];
}

@end
