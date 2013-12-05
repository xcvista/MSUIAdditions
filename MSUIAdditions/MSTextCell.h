//
//  NumeriTextCell.h
//  Numeri
//
//  Created by Maxthon Chan on 10/15/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSTextCell;

@protocol MSTextCellDelegate <NSObject>

@optional
- (void)textCellDidFinishTyping:(MSTextCell *)textCell;

@end

@interface MSTextCell : UITableViewCell <UITextFieldDelegate>

@property NSCharacterSet *validCharacterSet;
@property NSUInteger maxLength;
@property BOOL solitude;
@property IBOutlet id<MSTextCellDelegate> delegate;

@property (weak) IBOutlet UITextField *textField;
@property (weak) IBOutlet UIButton *confirmButton;

- (IBAction)confirm:(id)sender;

@end
