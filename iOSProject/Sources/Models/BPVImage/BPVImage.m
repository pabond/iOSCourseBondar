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
BPVStringConstant(BPVImages);

@interface BPVImage ()
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSURL         *url;
//@property (nonatomic, strong) NSMapTable    *images;

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
    if (self) {
        self.url = url;
    }
    
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
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = self.path;
    UIImage *image = nil;
    
    if (![fileManager fileExistsAtPath:filePath]) {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.url];
        BPVPerformAsyncBlockOnBackgroundQueue(^{
            [imageData writeToFile:filePath atomically:YES];
        });
        
        image = [UIImage imageWithData:imageData];
    } else {
        image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            [fileManager removeItemAtPath:filePath error:nil];
            [self performLoading];
        }
    }
        
    self.image = image;
        
    sleep(kBPVSleepTime);
    self.state = self.image ? BPVModelDidLoad : BPVModelFailLoading;
}

@end
