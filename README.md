ios-darken-image-with-cifilter
==============================

**UPDATE: You shouldn't use this any more - Apple's UIImage+ImageEffects code (released alongside iOS 7) achieves this same result - so go find it!**

I was frustrated trying to get a CIFilter that'd work to darken an image by 50% (the equivalent, in photoshop, to adding a 0.5-alpha black layer in front of a picture). An hour later, I figured it out. Enjoy!

Here's the code that does the magic:
```objectivec
-(instancetype)darkened:(CGFloat)alpha andBlurredImage:(CGFloat)radius blendModeFilterName:(NSString *)blendModeFilterName {
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //First, we'll use CIAffineClamp to prevent black edges on our blurred image
    //CIAffineClamp extends the edges off to infinity (check the docs, yo)
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKeyPath:kCIInputImageKey];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKeyPath:@"inputTransform"];
    CIImage *clampedImage = [clampFilter outputImage];
    
    //Next, create some darkness
    CIFilter* blackGenerator = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    CIColor* black = [CIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha];
    [blackGenerator setValue:black forKey:@"inputColor"];
    CIImage* blackImage = [blackGenerator valueForKey:@"outputImage"];
    
    //Apply that black
    CIFilter *compositeFilter = [CIFilter filterWithName:blendModeFilterName];
    [compositeFilter setValue:blackImage forKey:@"inputImage"];
    [compositeFilter setValue:clampedImage forKey:@"inputBackgroundImage"];
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
```

In a few lines of code, YOU TOO can witness this miracle transformation:
![iOS Screenshot](http://clrk.it/image/3v070D1n3S2u/core%20image%20demo%20image.png)
