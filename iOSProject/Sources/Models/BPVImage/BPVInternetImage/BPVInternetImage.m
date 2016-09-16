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

@end

@implementation BPVInternetImage

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    if (![self imageExistInFileSystem]) {
        NSData *imageData = [NSData dataWithContentsOfURL:self.url];
        [self saveDataToFileSystem:imageData];
        NSLog(@"Image loaded from internet");
    }
    
    [super performLoading];
}

#pragma mark -
#pragma mark Private implementations

- (void)saveDataToFileSystem:(NSData *)data {
    if (![self imageExistInFileSystem]) {
        [data writeToFile:self.path atomically:YES];
    }
}

@end
