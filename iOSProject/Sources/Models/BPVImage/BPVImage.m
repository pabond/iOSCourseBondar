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

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVSleepTime, 3);
BPVStringConstant(BPVImages);

@interface BPVImage ()
@property (nonatomic, strong) UIImage           *image;
@property (nonatomic, strong) NSURL             *url;
@property (nonatomic, strong) BPVImagesCache    *cache;

- (instancetype)initWithUrl:(NSURL *)url;

@end

@implementation BPVImage

@dynamic path;
@dynamic fileName;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    self.url = url;
    self.cache = [BPVImagesCache cache];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    BPVWeakify(self)
    BPVReturnOnce(NSString, path, ^{
        BPVStrongify(self)
        return [[NSFileManager applicationDataPathWithFolderName:BPVImages] stringByAppendingPathComponent:self.fileName];
    });
}

- (NSString *)fileName {
    BPVWeakify(self)
    BPVReturnOnce(NSString, fileName, ^{
        BPVStrongify(self)
        return [self.url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
    });
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    sleep(kBPVSleepTime);
    self.image = [self shouldLoadFromInternet] ? [self imageFromInternet] : [self imageFromFileSystem];
    
    self.state = self.image ? BPVModelDidLoad : BPVModelFailLoading;
}

- (BOOL)shouldLoadFromInternet {
    NSURL *url = self.url;
    
    return !url.isFileReferenceURL && ![self.cache containsImageWithURL:url];
}

#pragma mark -
#pragma mark Private implementations

- (UIImage *)imageFromFileSystem {
    NSString *filePath = self.path;
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (!image) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        [self performLoading];
    } else {
        NSLog(@"image loaded from file system");
    }
    
    return image;
}

- (UIImage *)imageFromInternet {
    NSURL *url = self.url;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    [imageData writeToFile:self.path atomically:YES];
    UIImage *image = [UIImage imageWithData:imageData];
    
    [self.cache addImage:self withURL:url];
    NSLog(@"Image loaded from internet");
    
    return image;
}

@end
