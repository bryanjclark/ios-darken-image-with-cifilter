//
//  UIImage+BlurAndDarken.h
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BlurAndDarken)

-(instancetype)darkened:(CGFloat)alpha andBlurredImage:(CGFloat)radius blendModeFilterName:(NSString *)blendModeFilterName;
-(instancetype)darkened:(CGFloat)alpha andBlurredImage:(CGFloat)radius;
-(instancetype)darkenedAndBlurredImage;

@end
