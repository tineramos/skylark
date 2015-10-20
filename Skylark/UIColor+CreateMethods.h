//
//  UIColor+CreateMethods.h
//  Philstocks
//
//  Created by Tine Ramos on 4/22/15.
//  Copyright (c) 2015 Lancera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CreateMethods)

+ (UIColor *)colorWithHex:(NSString *)hexString;
+ (UIColor *)colorWithHex:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)getDominantColor:(UIImage *)image;

@end
