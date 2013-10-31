//
//  MSAsyncImageCell.h
//  MSUIToolkit
//
//  Created by Maxthon Chan on 10/16/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSAsyncImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *asyncImageView;
@property UIImage *defaultImage;
@property NSURL *imageURL;

@end
