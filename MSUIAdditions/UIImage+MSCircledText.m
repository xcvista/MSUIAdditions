//
//  UIImage+NumeriCircledText.m
//  Numeri
//
//  Created by Maxthon Chan on 10/21/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "UIImage+MSCircledText.h"

@implementation UIImage (MSCircledText)

+ (instancetype)iconWithText:(NSString *)text size:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = {CGPointZero, size};
    
    // Circle
    CGContextAddEllipseInRect(ctx, CGRectInset(rect, 1, 1));
    CGContextSetLineWidth(ctx, 1);
    [color setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // Letter
    NSAttributedString *attribString = [[NSAttributedString alloc] initWithString:text
                                                                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                                                    NSForegroundColorAttributeName: color}];
    CGSize stringSize = [attribString size];
    CGRect stringRect = {CGPointMake(CGRectGetMidX(rect) - stringSize.width / 2, CGRectGetMidY(rect) - stringSize.height / 2), stringSize};
    [attribString drawInRect:stringRect];
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (instancetype)clockIconWithSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = {CGPointZero, size};
    
    // Circle
    CGContextAddEllipseInRect(ctx, CGRectInset(rect, 1, 1));
    CGContextSetLineWidth(ctx, 1);
    [color setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // Hands
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGPoint left = CGPointMake(center.x / 2, center.y);
    CGPoint top = CGPointMake(center.x, center.y / 4);
    
    CGContextMoveToPoint(ctx, left.x, left.y);
    CGContextAddLineToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, top.x, top.y);
    CGContextSetLineWidth(ctx, 1);
    [color setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
