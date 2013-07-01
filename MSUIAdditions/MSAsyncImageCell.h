///
///  @file      MSAsyncImageCell.h
///  @author    Maxthon Chan
///  @date      Jul. 1, 2013.
///  @copyright Copyright (c) 2013 muski. All rights reserved.
///

#import <UIKit/UIKit.h>

@class MSAsyncImageCell;

/**
 @brief     MSAsyncImageCell delegate.
 
 MSAsyncImageCellDelegate provides fine-grained control over asynchous loading
 of images.
 
 @see       MSAsyncImageCell
 */
@protocol MSAsyncImageCellDelegate <NSObject>

@optional

/**
 Notify the deleate that the image is being loaded.
 
 @param     cell    The cell calling this delegate method.
 @return    Whether the cell should proceed to load the image.
 */
- (BOOL)asyncImageCellShouldLoadURLRequest:(MSAsyncImageCell *)cell;

/**
 Enqueue a block that loads the image.
 
 @warning   You must either not implement this method, or actually queue the 
            block for actually running, or the image will never be loaded.
 
 @param     cell    The cell calling this delegate method.
 @param     block   The load block. You must enqueue it for running or no image
                    will be loaded and no delegate method will be sent.
 @see       dispatch_async()
 @see       dispatch_block_async()
 */
- (void)    asyncImageCell:(MSAsyncImageCell *)cell
          enqueueLoadBlock:(dispatch_block_t)block;

/** 
 Notify the delegate that image load has completed.
 
 @param     cell    The cell calling this delegate method.
 @param     error   If an error occured during loading, it is passed here.
 
 @note      If the address is changed during load, the downloaded data is
            discarded and this method is called. You can use -[MSAsyncImageCell
            loadImage] to retry loading the image.
 
 @see       -[MSAsyncImageCell loadImage]
 */
- (void)    asyncImageCell:(MSAsyncImageCell *)cell
 didFinishLoadingWithError:(NSError *)error;

@end

/**
 @brief     Table view cell that loads images asynchronizedly.
 
 MSAsyncImageCell is a UITableViewCell that loads its image asynchorously using
 Grand Central Dispatch.
 
 @see       MSAsyncImageCellDelegate
 */
@interface MSAsyncImageCell : UITableViewCell

/** 
 Cache policy used during loading.
 */
@property NSURLCacheStoragePolicy cacheStoragePolicy;

/**
 URL Request of loading the image in question.
 */
@property NSURLRequest *imageURLRequest;

/**
 Cell delegate.
 
 @see       MSAsyncImageCellDelegate
 */
@property (weak) IBOutlet id<MSAsyncImageCellDelegate> delegate;

/**
 Loads up the image.
 */
- (void)loadImage;

/**
 Notify the deleate that the image is being loaded.
 
 @return    Whether the cell should proceed to load the image.
 */
- (BOOL)cellShouldLoadURLRequest;

/**
 Enqueue a block that loads the image.
 
 @warning   You must either not implement this method, or actually queue the
 block for actually running, or the image will never be loaded.
 
 @param     block   The load block. You must enqueue it for running or no image
            will be loaded and no delegate method will be sent.
 @see       dispatch_async()
 @see       dispatch_block_async()
 */
- (void)enqueueLoadBlock:(dispatch_block_t)block;

/**
 Notify the delegate that image load has completed.
 
 @param     cell    The cell calling this delegate method.
 @param     error   If an error occured during loading, it is passed here.
 
 @note      If the address is changed during load, the downloaded data is
            discarded and this method is called. You can use -[MSAsyncImageCell
            loadImage] to retry loading the image.
 
 @see       -[MSAsyncImageCell loadImage]
 */
- (void)cellDidFinishLoadingWithError:(NSError *)error;

@end
