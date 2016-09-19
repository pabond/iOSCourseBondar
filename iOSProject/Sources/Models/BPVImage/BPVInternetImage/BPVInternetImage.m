//
//  BPVInternetImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVInternetImage.h"
#import "BPVImagesCache.h"

@interface BPVInternetImage ()

- (void)saveDataToFileSystem:(NSData *)data;
- (BOOL)removeImageWithProblem;
- (void)reloadImage;

@end

@implementation BPVInternetImage

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    UIImage *image = nil;
    
    if (![self imageLoaded]) {
        [self loadImageFormInternet];
    }
    
    image = [self imageFromFileSystem];
    
    if (image) {
        self.image = image;
        NSLog(@"image will load from file system");
    } else {
        [self reloadImage];
    }
    
    self.state = image ? BPVModelDidLoad : BPVModelFailLoading;
}

#pragma mark -
#pragma mark Private implementations

- (void)saveDataToFileSystem:(NSData *)data {
    if (![self imageLoaded]) {
        [data writeToFile:self.path atomically:YES];
    }
}

#pragma mark -
#pragma mark NSURLSessionDownloadDelegate

- (void)        URLSession:(NSURLSession *)session
              downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didFinishDownloadingToURL:(NSURL *)location
{
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtURL:location
                                            toURL:self.url
                                            error:&error];
    
    NSLog(@"didFinishDownloadingToURL = notification");
}

#pragma mark -
#pragma mark Private implementations

- (void)reloadImage {
    [self removeImageWithProblem];
    [self performLoading];
}

- (BOOL)removeImageWithProblem {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    
    NSLog(@"%@", error);
    
    return result;
}

- (void)loadImageFormInternet {
    NSData *imageData = [NSData dataWithContentsOfURL:self.url];
    [self saveDataToFileSystem:imageData];
    NSLog(@"Image loaded from internet");
}

@end
