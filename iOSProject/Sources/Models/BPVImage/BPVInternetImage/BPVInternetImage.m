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
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    [imageData writeToFile:self.path atomically:YES];
    UIImage *image = [UIImage imageWithData:imageData];
    
    [[BPVImagesCache cache] addImage:self withURL:url];
    NSLog(@"Image loaded from internet");
    
    return image;
}

@end
