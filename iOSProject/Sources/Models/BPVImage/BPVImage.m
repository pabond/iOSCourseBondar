//
//  BPVImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

#import "BPVGCD.h"
#import "BPVQueue.h"
#import "BPVImagesCache.h"

#import "BPVLocalImage.h"
#import "BPVInternetImage.h"

@interface BPVImage ()

+ (instancetype)internetWithUrl:(NSURL *)url;
+ (instancetype)localImageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

@end

@implementation BPVImage

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    BPVImagesCache *cache = [BPVImagesCache cache];
    if ([cache containsImageWithURL:url]) {
        NSLog(@"Cached image will return");
        return [cache imageWithURL:url];
    }
    
    return url.isFileURL ? [BPVImage localImageWithUrl:url]
                            : [BPVImage internetWithUrl:url];
}

+ (instancetype)internetWithUrl:(NSURL *)url {
    return [[BPVInternetImage alloc] initWithUrl:url];
}

+ (instancetype)localImageWithUrl:(NSURL *)url {
    return [[BPVLocalImage alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
    [[BPVImagesCache cache] removeImageWithURL:self.url];
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    self.url = url;
    [[BPVImagesCache cache] addImage:self withURL:url];
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)finishLoadingImage:(UIImage *)image {
    self.image = image;
    self.state = image ? BPVModelDidLoad : BPVModelFailLoading;
}

@end
