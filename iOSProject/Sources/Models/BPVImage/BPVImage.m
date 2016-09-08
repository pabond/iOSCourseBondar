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

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVSleepTime, 3);

@interface BPVImage ()
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSURL         *url;
//@property (nonatomic, strong) NSMapTable    *images;

- (instancetype)initWithUrl:(NSURL *)url;

@end

@implementation BPVImage

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self imagePathInFileSystem];
    UIImage *image = nil;
    
    @synchronized (self) {
        if (![fileManager fileExistsAtPath:filePath]) {
            image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:self.url]];
            NSData * imageData = UIImagePNGRepresentation(image);
            [imageData writeToFile:filePath atomically:YES];
        } else {
            image = [UIImage imageWithContentsOfFile:[self imagePathInFileSystem]];
        }
        
        self.image = image;
        
        sleep(kBPVSleepTime);
        self.state = self.image ? BPVModelDidLoad : BPVModelFailLoading;
    }
}

#pragma mark -
#pragma mark Private implementations

- (NSString *)imagePathInFileSystem {
    NSString *path = [[NSFileManager applicationDataPath] stringByAppendingPathComponent:self.url.path];
    NSLog(@"path = %@", path);
    
    return path;
}

@end
