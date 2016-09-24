//
//  BPVInternetImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVInternetImage.h"

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(BPVImages);

@interface BPVInternetImage ()
@property (nonatomic, strong)   NSURLSessionTask    *task;
@property (nonatomic, readonly) NSURL               *localURL;
@property (nonatomic, readonly) NSString            *path;
@property (nonatomic, readonly) NSString            *fileName;

- (BOOL)cached;
- (BOOL)removeCorruptedImage;

@end

@implementation BPVInternetImage

@dynamic localURL;
@dynamic path;
@dynamic fileName;

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    return [NSURL fileURLWithPath:self.path];
}

- (NSString *)path {
    return [[NSFileManager applicationDataPathWithFolderName:BPVImages] stringByAppendingPathComponent:self.fileName];
}

- (NSString *)fileName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}


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
    UIImage *image = [self imageWithURL:self.localURL];
    if (image) {
        [self finishLoadingImage:image];
    } else {
        [self removeCorruptedImage];
        [self loadFromInternet];
    }
}

- (NSURLSession *)session {
    return [NSURLSession sharedSession];
}

- (BPVCompletionHandler)downloadTaskCompletionHandler {
    return ^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            self.state = BPVModelFailLoading;
            return;
        }
        
        NSURL *url = self.localURL;
        
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:url error:nil];
        
        NSLog(@"Image loaded from internet");
        UIImage *image = [self imageWithURL:location];
        
        [self finishLoadingImage:image];
    };
}

- (void)loadFromInternet {
    self.task = [[self session] downloadTaskWithURL:self.url completionHandler:[self downloadTaskCompletionHandler]];
}

#pragma mark -
#pragma mark Private implementations

- (BOOL)removeCorruptedImage {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    
    NSLog(@"%@", error);
    
    return result;
}

- (BOOL)cached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

@end
