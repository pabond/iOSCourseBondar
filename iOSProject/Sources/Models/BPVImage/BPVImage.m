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

BPVStringConstant(BPVImages);

@interface BPVImage ()

+ (instancetype)internetWithUrl:(NSURL *)url;
+ (instancetype)fileSystemImageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

@end

@implementation BPVImage

@dynamic path;
@dynamic fileName;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageWithUrl:(NSURL *)url {
    BPVImagesCache *cache = [BPVImagesCache cache];
    if ([cache containsImageWithURL:url]) {
        NSLog(@"Cached image will return");
        return [cache imageWithURL:url];
    }
    
    return url.isFileURL ? [BPVImage fileSystemImageWithUrl:url]
                            : [BPVImage internetWithUrl:url];
}

+ (instancetype)internetWithUrl:(NSURL *)url {
    return [[BPVInternetImage alloc] initWithUrl:url];
}

+ (instancetype)fileSystemImageWithUrl:(NSURL *)url {
    return [[BPVFileSystemImage alloc] initWithUrl:url];
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
#pragma mark Accessors

- (NSString *)path {
    return [[NSFileManager applicationDataPathWithFolderName:BPVImages] stringByAppendingPathComponent:self.fileName];
}

- (NSString *)fileName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

@end
