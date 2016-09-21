//
//  BPVLocalImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLocalImage.h"

@implementation BPVLocalImage

#pragma mark -
#pragma mark Public implementations

- (UIImage *)imageWithURL:(NSURL *)url {
    return [UIImage imageWithContentsOfFile:[url absoluteString]];
}

@end
