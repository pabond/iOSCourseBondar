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

- (void)finishImageLoading;

@end

@implementation BPVInternetImage

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    if (![self imageLoaded]) {
        [self loadImageFormInternet];
        return;
    } else {
        [self finishImageLoading];
    }
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

- (BOOL)removeImageWithProblem {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
        
    NSLog(@"%@", error);
        
    return result;
}

- (NSURLSessionTask *)loadingTask {
    NSURLSession *session = [NSURLSession sharedSession];
    return [session dataTaskWithURL:self.url
                                    completionHandler:^(NSData * _Nullable data,
                                                        NSURLResponse * _Nullable response,
                                                        NSError * _Nullable error) {
                                        if (!error) {
                                            [self saveDataToFileSystem:data];
                                            NSLog(@"Image loaded from internet");
                                            [self finishImageLoading];
                                        }
                                    }];
}

- (void)loadImageFormInternet {
    NSURLSessionTask *task = [self loadingTask];
    [task resume];
}

- (void)finishImageLoading {
    @synchronized (self) {
        NSUInteger state = BPVModelDidLoad;
        UIImage *image = [self imageFromFileSystem];
        
        if (image) {
            self.image = image;
        } else {
            [self removeImageWithProblem];
            state = BPVModelFailLoading;
        }
        
        self.state = state;
    }
}

@end
