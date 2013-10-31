//
//  MSRoundedRectButton.m
//  MSUIToolkit
//
//  Created by Maxthon Chan on 10/28/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSRoundedRectButton.h"

@implementation MSRoundedRectButton

+ (void)initialize
{
    MSRoundedRectButton *button = [self appearance];
    button.borderWidth = 1.0;
    button.cornerRadius = -1.0;
    button.borderColor = nil;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat borderWidth = self.borderWidth;
    CGFloat cornerRadius = self.cornerRadius;
    CGRect bounds = self.bounds;
    UIColor *color = self.borderColor;
    
    if (borderWidth < 0)
        borderWidth = 1;
    bounds = CGRectInset(bounds, borderWidth / 2, borderWidth / 2);
    if (cornerRadius < 0)
        cornerRadius = MIN(CGRectGetHeight(bounds), CGRectGetWidth(bounds)) / 2;
    if (!color)
        color = [self currentTitleColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    [path setLineWidth:borderWidth];
    [color setStroke];
    [path stroke];
}

@end
