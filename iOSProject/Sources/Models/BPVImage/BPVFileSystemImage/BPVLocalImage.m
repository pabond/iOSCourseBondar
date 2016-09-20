//
//  BPVLocalImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLocalImage.h"

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(BPVImages);

@interface BPVLocalImage ()
@property (nonatomic, readonly) NSString    *fileName;

@end

@implementation BPVLocalImage

@dynamic localURL;
@dynamic path;
@dynamic fileName;

#pragma mark -
#pragma mark Accessors

- (NSURL *)localURL {
    return [NSURL URLWithString:self.path];
}

- (NSString *)path {
    return [[NSFileManager applicationDataPathWithFolderName:BPVImages] stringByAppendingPathComponent:self.fileName];
}

- (NSString *)fileName {
    NSCharacterSet *characterSet = [NSCharacterSet URLUserAllowedCharacterSet];
    
    return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    [self finishLoadingImage:[self performLoadingWithURL:self.localURL]];
}

- (BOOL)cached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (UIImage *)performLoadingWithURL:(NSURL *)url {
    return [UIImage imageWithContentsOfFile:[url absoluteString]];
}

@end
