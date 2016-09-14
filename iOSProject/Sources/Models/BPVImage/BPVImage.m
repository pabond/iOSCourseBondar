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

#import "BPVFileSystemImage.h"
#import "BPVInternetImage.h"

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVSleepTime, 3);
BPVStringConstant(BPVImages);

@interface BPVImage ()

+ (instancetype)internetWithUrl:(NSURL *)url;
+ (instancetype)fileSystemImageWithUrl:(NSURL *)url;

@end

@implementation BPVImage

@dynamic path;
@dynamic fileName;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

+ (instancetype)internetWithUrl:(NSURL *)url {
    return [[BPVInternetImage alloc] initWithUrl:url];
}

+ (instancetype)fileSystemImageWithUrl:(NSURL *)url {
    return [[BPVFileSystemImage alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUrl:(NSURL *)url {
    BPVImagesCache *cache = [BPVImagesCache cache];
    if ([cache containsImageWithURL:url]) {
        return [cache imageWithURL:url];
    }   
    
    return [url isFileURL] ? [BPVFileSystemImage fileSystemImageWithUrl:url]
                            : [BPVInternetImage internetWithUrl:url];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [[NSFileManager applicationDataPathWithFolderName:BPVImages] stringByAppendingPathComponent:self.fileName];
}

- (NSString *)fileName {
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
                                                                                        URLUserAllowedCharacterSet]];
}

#pragma mark -
#pragma mark Public implementations

- (UIImage *)specificLoadingOperation {
    return nil;
}

- (void)performLoading {
    UIImage *image = [self specificLoadingOperation];
    sleep(kBPVSleepTime);
    
    self.image = image;
    
    self.state = image ? BPVModelDidLoad : BPVModelFailLoading;
}

#pragma mark -
#pragma mark Private implementations

@end
