//
//  BPVInternetImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVInternetImage.h"
#import "BPVImagesCache.h"

@implementation BPVInternetImage

- (UIImage *)specificLoadingOperation {
    NSURL *url = self.url;
    UIImage *image = nil;
    
    if ([self imageExistInFileSystem]) {
        image = [super specificLoadingOperation];
    } else {
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        [self saveDataToFileSystem:imageData];
        
        image = [UIImage imageWithData:imageData];
        NSLog(@"Image loaded from internet");
    }
    
    [[BPVImagesCache cache] addImage:self withURL:url];
    
    return image;
}

@end
