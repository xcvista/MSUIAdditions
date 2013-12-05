//
//  NumeriTextCell.m
//  Numeri
//
//  Created by Maxthon Chan on 10/15/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSTextCell.h"

@implementation MSTextCell

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Enforce max length
    if (self.maxLength)
    {
        if ([textField.text length] - range.length + [string length] > self.maxLength)
            return NO;
    }
    
    // Enforce valid characters
    if (self.validCharacterSet)
    {
        if ([[[string componentsSeparatedByCharactersInSet:self.validCharacterSet] componentsJoinedByString:@""] length])
            return NO;
    }
    
    // Enforce solitude
    if (self.solitude)
    {
        NSMutableCharacterSet *existing = [NSMutableCharacterSet characterSetWithCharactersInString:textField.text];
        NSCharacterSet *new = [NSCharacterSet characterSetWithCharactersInString:string];
        [existing formIntersectionWithCharacterSet:new];
        NSData *result = [existing bitmapRepresentation];
        NSData *empty = [NSMutableData dataWithLength:8192];
        if (![result isEqualToData:empty])
            return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self confirm:textField];
    return YES;
}

- (void)confirm:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(textCellDidFinishTyping:)])
        [self.delegate textCellDidFinishTyping:self];
}

@end
