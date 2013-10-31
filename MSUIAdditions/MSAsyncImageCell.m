//
//  MSAsyncImageCell.m
//  MSUIToolkit
//
//  Created by Maxthon Chan on 10/16/13.
//  Copyright (c) 2013 muski. All rights reserved.
//

#import "MSAsyncImageCell.h"

@interface MSAsyncImageCell () <NSURLConnectionDataDelegate>

@property NSURL *currentURL;
@property NSURLConnection *currentConnection;
@property NSURLRequest *currentRequest;
@property NSURLResponse *currentResponse;
@property NSMutableData *localData;

@end

@implementation MSAsyncImageCell

@synthesize imageURL = _imageURL;
@synthesize asyncImageView = _asyncImageView;

- (UIImageView *)asyncImageView
{
    if (!_asyncImageView)
        _asyncImageView = self.imageView;
    
    return _asyncImageView;
}

- (NSURL *)imageURL
{
    @synchronized (self)
    {
        return _imageURL;
    }
}

- (void)setImageURL:(NSURL *)imageURL
{
    @synchronized (self)
    {
        _imageURL = imageURL;
        [self _loadImage];
    }
}

- (void)_loadImage
{
    // If the new URL is the same as the old one, done.
    
    if ([[self.currentURL absoluteString] isEqualToString:[self.imageURL absoluteString]])
        return;
    
    self.currentURL = self.imageURL;
    
    // If there is still an ongoing loading session, abort it.
    
    if (self.currentConnection)
    {
        [self.currentConnection cancel];
        self.currentConnection = nil;
    }
    
    // Local files get loaded right away.
    
    if ([[self.imageURL scheme] hasPrefix:@"file"])
    {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
        [self _loadImageWithData:imageData];
        
        return;
    }
    
    // Make the request.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    
    // Check the cache for this file
    
    NSURLCache *cache = [NSURLCache sharedURLCache];
    
    NSCachedURLResponse *cached = [cache cachedResponseForRequest:request];
    
    if (cached)
    {
        // Cache hit - load it here.
        
        [self _loadImageWithData:[cached data]];
    }
    else
    {
        // Cache miss - download it.
        
        if (![NSURLConnection canHandleRequest:request])
        {
            // Eh it doesn't even work.
            return;
        }
        
        self.currentRequest = request;
        self.currentConnection = [NSURLConnection connectionWithRequest:request
                                                               delegate:self];
    }
}

- (BOOL)_loadImageWithData:(NSData *)imageData
{
    UIImage *image = [UIImage imageWithData:imageData];
    
    // Just in case loading failed.
    
    if (image)
    {
        // Extra check - don't mix up.
        if ([[self.currentURL absoluteString] isEqualToString:[self.imageURL absoluteString]])
            self.asyncImageView.image = image;
        
        return YES;
    }
    
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (connection != self.currentConnection)
        return;
    
    self.currentResponse = response;
    
    if ([response expectedContentLength] != NSURLResponseUnknownLength)
    {
        // I have a length! Preallocate now.
        self.localData = [NSMutableData dataWithCapacity:[response expectedContentLength]];
    }
    else
    {
        // I will have to trial and error.
        self.localData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection != self.currentConnection)
        return;
    
    // A piece of something arrived. Concatenate it.
    [self.localData appendData:data];
    
    if ([self.currentResponse expectedContentLength] != NSURLResponseUnknownLength)
    {
        if ([self.localData length] >= [self.currentResponse expectedContentLength])
        {
            // I have a length and it is all here.
            [self.localData setLength:(NSUInteger)[self.currentResponse expectedContentLength]];
            
            if ([self _loadImageWithData:self.localData])
            {
                // It is an image and it is loaded.
                NSURLCache *cache = [NSURLCache sharedURLCache];
                [cache storeCachedResponse:[[NSCachedURLResponse alloc] initWithResponse:self.currentResponse
                                                                                    data:self.localData]
                                forRequest:self.currentRequest];
            }
        }
    }
    else
    {
        // Trying it piecemeal.
        if ([self _loadImageWithData:self.localData])
        {
            // Some image is here and loaded.
            NSURLCache *cache = [NSURLCache sharedURLCache];
            [cache storeCachedResponse:[[NSCachedURLResponse alloc] initWithResponse:self.currentResponse
                                                                                data:self.localData]
                            forRequest:self.currentRequest];
            
            [self.currentConnection cancel];
            self.currentConnection = nil;
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (connection != self.currentConnection)
        return;
    
    // It is not loaded.
    self.currentConnection = nil;
}

@end
