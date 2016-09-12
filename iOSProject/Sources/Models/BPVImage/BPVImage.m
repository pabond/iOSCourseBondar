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
        return [[self.url absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    });
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    BPVImagesCache *cache = self.cache;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = self.path;
    UIImage *image = nil;
    NSURL *url = self.url;
    
    sleep(kBPVSleepTime);
    
    if ([cache containsImageWithURL:url]) {
        image = [cache imageWithURL:url];
        if (!image) {
            [cache removeImageWithURL:url];
            [self reload];
        } else {
            NSLog(@"Image loaded afrom cache");
        }
    } else if ([fileManager fileExistsAtPath:filePath]) {
        image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            [fileManager removeItemAtPath:filePath error:nil];
            [self reload];
        } else {
            NSLog(@"image loaded from file system");
        }
    } else {
        image = [self loadImageFromInternet];
    }
        
    self.image = image;
    self.state = self.image ? BPVModelDidLoad : BPVModelFailLoading;
}

#pragma mark -
#pragma mark Private implementations

- (UIImage *)loadImageFromInternet {
    NSURL *url = self.url;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    [imageData writeToFile:self.path atomically:YES];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.cache addImage:image withURL:url];
    NSLog(@"Image loaded from internet");
    
    return image;
}

- (void)reload {
    self.state = BPVModelDidUnload;
    [self load];
}

@end
