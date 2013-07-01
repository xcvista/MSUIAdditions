//
//  MSAsyncImageCell.m
//  MSUIAdditions
//
//  Created by Maxthon Chan on 7/1/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSAsyncImageCell.h"

@implementation MSAsyncImageCell

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
}

- (void)loadImage
{
    if (![self cellShouldLoadURLRequest])
        return;
    
    NSURLRequest *request = nil;
    @synchronized (self)
    {
        request = self.imageURLRequest;
    }
    
    [self enqueueLoadBlock:^{
        
        // Query cache
        NSCachedURLResponse *cachedResponse = nil;
        
        if (self.cacheStoragePolicy != NSURLCacheStorageNotAllowed)
        {
            NSURLCache *cache = [NSURLCache sharedURLCache];
            cachedResponse = [cache cachedResponseForRequest:request];
        }
        
        if (!cachedResponse)
        {
            // Cache miss. Grab it from server.
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:self.imageURLRequest
                                                 returningResponse:&response
                                                             error:&error];
            
            if (!data)
            {
                // Oops, no data.
                if (error)
                    [self cellDidFinishLoadingWithError:error];
                else
                    [self cellDidFinishLoadingWithError:[NSError errorWithDomain:NSPOSIXErrorDomain
                                                                            code:ENODATA
                                                                        userInfo:nil]];
            }
            else
            {
                UIImage *image = [UIImage imageWithData:data];
                if (!image)
                {
                    // What the hell did I got?
                    [self cellDidFinishLoadingWithError:[NSError errorWithDomain:NSPOSIXErrorDomain
                                                                            code:EFTYPE
                                                                        userInfo:nil]];
                }
                else
                {
                    // Cache it, if allowed.
                    if (self.cacheStoragePolicy != NSURLCacheStorageNotAllowed)
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            NSURLCache *cache = [NSURLCache sharedURLCache];
                            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response
                                                                                                           data:data
                                                                                                       userInfo:nil
                                                                                                  storagePolicy:self.cacheStoragePolicy];
                            [cache storeCachedResponse:cachedResponse forRequest:request];
                        });
                    
                    if ([request isEqual:self.imageURLRequest])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.imageView.image = image;
                        });
                        [self cellDidFinishLoadingWithError:nil];
                    }
                    else
                    {
                        // Oops, too slow.
                        [self cellDidFinishLoadingWithError:[NSError errorWithDomain:NSPOSIXErrorDomain
                                                                                code:ETIMEDOUT
                                                                            userInfo:nil]];
                    }
                }
            }
        }
    }];
}

- (BOOL)cellShouldLoadURLRequest
{
    if ([self.delegate respondsToSelector:@selector(asyncImageCellShouldLoadURLRequest:)])
        return [self.delegate asyncImageCellShouldLoadURLRequest:self];
    else
        return YES;
}

- (void)enqueueLoadBlock:(dispatch_block_t)block
{
    if ([self.delegate respondsToSelector:@selector(asyncImageCell:enqueueLoadBlock:)])
        [self.delegate asyncImageCell:self enqueueLoadBlock:block];
    else
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)cellDidFinishLoadingWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(asyncImageCell:didFinishLoadingWithError:)])
        [self.delegate asyncImageCell:self didFinishLoadingWithError:error];
}

@end
