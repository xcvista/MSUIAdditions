///
///  @file      MSTextFieldCell.h
///  @author    Maxthon Chan
///  @date      Jul. 1, 2013.
///  @copyright Copyright (c) 2013 muski. All rights reserved.
///

#import <UIKit/UIKit.h>

/**
 @brief     A table view cell with a text field in it.
 
 A table view cell with a text field in it. Good for table-filling scenes.
 
 @note      Currently no layout is done, so you need to resort to other means of
            layout building schemes to make it look good.
 */
@interface MSTextFieldCell : UITableViewCell

/**
 The outlet pointing to the text field.
 */
@property (weak) IBOutlet UITextField *textField;

@end
