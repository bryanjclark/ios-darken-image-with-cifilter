//
//  BCImageProcessor.h
//  CoreImageDemo
//
//  Created by Bryan Clark on 3/17/13.
//  Copyright (c) 2013 Bryan Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCImageProcessor : NSObject

+(UIImage *)darkenedAndBlurredImageForImage:(UIImage *)image;

@end
