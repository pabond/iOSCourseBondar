//
//  BPVInternetImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVInternetImage.h"

@interface BPVInternetImage ()
@property (nonatomic, strong) NSURLSessionTask *task;

- (BOOL)removeCorruptedImage;
- (void)loadFormInternet;

@end

@implementation BPVInternetImage

#pragma mark -
#pragma mark Initaializations and deallocations

- (void)dealloc {
    self.task = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setTask:(NSURLSessionTask *)task {
    if (_task != task) {
        [_task cancel];
        
        _task = task;
        [_task resume];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    if ([self cached]) {
        UIImage *image = [super performLoadingWithURL:self.localURL];
        if (!image) {
            [self removeCorruptedImage];
            [self performLoading];
        } else {
            [self finishLoadingImage:image];
        }
    } else {
        [self loadFormInternet];
    }
}

#pragma mark -
#pragma mark Private implementations

- (void)loadFormInternet {
    NSURLSession *session = [NSURLSession sharedSession];
    
    self.task = [session downloadTaskWithURL:self.url completionHandler:^(NSURL * _Nullable location,
                                                                          NSURLResponse * _Nullable response,
                                                                          NSError * _Nullable error)
                 {
                     [[NSData dataWithContentsOfURL:location] writeToFile:self.path atomically:YES];
                     NSLog(@"Image loaded from internet");
                     
                     [super performLoading];
                 }];
}

- (BOOL)removeCorruptedImage {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    
    NSLog(@"%@", error);
    
    return result;
}

@end
