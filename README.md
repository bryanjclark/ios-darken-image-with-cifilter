ios-darken-image-with-cifilter
==============================

I was frustrated trying to get a CIFilter that'd work to darken an image by 50% (the equivalent, in photoshop, to adding a 0.5-alpha black layer in front of a picture). An hour later, I figured it out. Enjoy!

Here's the code that does the magic:
```objectivec
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
```

In a few lines of code, YOU TOO can witness this miracle transformation:
![iOS Screenshot](http://f.cl.ly/items/1S2q102q3d2G41232q3V/iOS%20Simulator%20Screen%20shot%20Apr%203,%202013%2011.58.28%20AM.png)
