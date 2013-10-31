//
//  MSRoundedRectButton.h
//  MSUIToolkit
//
//  Created by Maxthon Chan on 10/28/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSRoundedRectButton : UIButton

@property CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property UIColor *borderColor UI_APPEARANCE_SELECTOR;

@end
