//
//  MSUnderlinedTextField.m
//  MSUIToolkit
//
//  Created by Maxthon Chan on 10/28/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSUnderlinedTextField.h"

@implementation MSUnderlinedTextField

+ (void)initialize
{
    MSUnderlinedTextField *field = [self appearance];
    
    field.lineWidth = 1.0;
    field.lineColor = [UIColor lightGrayColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat lineWidth = self.lineWidth;
    UIColor *color = self.lineColor;
    
    if (lineWidth < 0)
        lineWidth = 1;
    if (!color)
        color = [UIColor lightGrayColor];
    
    // Get text locations
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    UIFont *currentFont = self.font;
    
    CGFloat fontHeight = [currentFont lineHeight];
    CGFloat descenderHeight = fabs([currentFont descender]);
    
    CGRect mainRect = CGRectInset(textRect, lineWidth / 2, (CGRectGetHeight(textRect) - fontHeight) / 2 + lineWidth / 2);
    
    CGContextMoveToPoint(ctx, CGRectGetMinX(mainRect), CGRectGetMaxY(mainRect) - descenderHeight);
    CGContextAddLineToPoint(ctx, CGRectGetMinX(mainRect), CGRectGetMaxY(mainRect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(mainRect), CGRectGetMaxY(mainRect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(mainRect), CGRectGetMaxY(mainRect) - descenderHeight);
    
    CGContextSetLineWidth(ctx, lineWidth);
    [color setStroke];
    CGContextDrawPath(ctx, kCGPathStroke);
}

@end
