//
//  UIColor+CreateMethods.m
//  Philstocks
//
//  Created by Tine Ramos on 4/22/15.
//  Copyright (c) 2015 Lancera. All rights reserved.
//

#import "UIColor+CreateMethods.h"

@implementation UIColor (CreateMethods)

+ (UIColor *)colorWithHex:(NSString *)hexString
{
    return [[self class] colorWithHex:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 6) {
        hexString = [NSString stringWithFormat:@"#%@",hexString];
    }
    if(hexString.length == 7 && [[hexString substringToIndex:1] isEqualToString:@"#"]) {
        NSString *lowerCase = [hexString lowercaseString];
        const char *colorUTF8String = [lowerCase UTF8String];
        int r, g, b;
        sscanf(colorUTF8String, "#%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:alpha];
    }
    return [UIColor clearColor];
}

struct pixel {
    unsigned char r, g, b, a;
};

//CGBitmapInfo
+ (UIColor *)getDominantColor:(UIImage *)image
{
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
    // Allocate a buffer big enough to hold all the pixels
    struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    if (pixels != nil)
    {
        
        CGContextRef context = CGBitmapContextCreate(
                                                     (void*) pixels,
                                                     image.size.width,
                                                     image.size.height,
                                                     8,
                                                     image.size.width * 4,
                                                     CGImageGetColorSpace(image.CGImage),
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                                                     );
        
        if (context != NULL)
        {
            // Draw the image in the bitmap
            
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
            
            // Now that we have the image drawn in our own buffer, we can loop over the pixels to
            // process it. This simple case simply counts all pixels that have a pure red component.
            
            // There are probably more efficient and interesting ways to do this. But the important
            // part is that the pixels buffer can be read directly.
            
            NSUInteger numberOfPixels = image.size.width * image.size.height;
            for (int i=0; i<numberOfPixels; i++) {
                red += pixels[i].r;
                green += pixels[i].g;
                blue += pixels[i].b;
            }
            
            red /= numberOfPixels;
            green /= numberOfPixels;
            blue/= numberOfPixels;
                        
            CGContextRelease(context);
        }
        
        free(pixels);
    }
    return [UIColor colorWithRed:(red*1.5)/255.0f green:((green*1.5)/255.0f) blue:((blue*1.5)/255.0f) alpha:1.0f];
}

@end
