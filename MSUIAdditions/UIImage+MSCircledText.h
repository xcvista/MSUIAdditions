//
//  UIImage+NumeriCircledText.h
//  Numeri
//
//  Created by Maxthon Chan on 10/21/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MSCircledText)

+ (instancetype)iconWithText:(NSString *)text size:(CGSize)size color:(UIColor *)color;
+ (instancetype)clockIconWithSize:(CGSize)size color:(UIColor *)color;

@end
