//
//  BPVImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

#import "BPVImageModelDispatcher.h"
#import "BPVGCD.h"
#import "BPVQueue.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVSleepTime, 3);

@interface BPVImage ()
@property (nonatomic, strong) UIImage                   *image;
@property (nonatomic, strong) NSURL                     *url;
@property (nonatomic, strong) BPVImageModelDispatcher   *imageDispatcher;

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
        BPVImageModelDispatcher *imageDispatcher = [BPVImageModelDispatcher shareDespatcher];
        self.imageDispatcher = imageDispatcher;
        [imageDispatcher loadImage:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setImageDispatcher:(BPVImageModelDispatcher *)imageDispatcher {
    if (_imageDispatcher != imageDispatcher) {
        [self removeObserver:_imageDispatcher];
        
        _imageDispatcher = imageDispatcher;
        [self addObserver:_imageDispatcher];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    @synchronized (self) {
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
        
        sleep(kBPVSleepTime);
        self.state =  self.image ? BPVModelDidLoad : BPVModelFailLoading;
        
        BPVImageModelDispatcher *imageDispatcher = self.imageDispatcher;
        if (imageDispatcher.queue.count) {
            [imageDispatcher loadImage:[imageDispatcher.queue dequeueObject]];
        }
    }
}

- (void)dump {
    self.image = nil;
    self.state = BPVModelDidUnload;
}

@end
