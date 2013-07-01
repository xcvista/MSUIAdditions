//
//  MSTextFieldCell.m
//  MSUIAdditions
//
//  Created by Maxthon Chan on 7/1/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSTextFieldCell.h"

@implementation MSTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.textField setHighlighted:self.highlighted || selected];
    
    if (selected)
    {
        [self.textField becomeFirstResponder];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [self.textField setHighlighted:highlighted || self.selected];
}

@end
