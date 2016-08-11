//
//  BPVImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

@interface BPVImage ()
@property (nonatomic, strong) UIImage       *image;
@property (nonatomic, strong) NSURL         *url;
@property (nonatomic, strong) NSOperation   *operation;

@property (nonatomic, assign, getter=isLoaded) BOOL loaded;

- (instancetype)initWithUrl:(NSURL *)url;

@end

@implementation BPVImage

@dynamic loaded;

#pragma mark -
#pragma mark Class methods

+ (instancetype)imageFromUrl:(NSURL *)url {
    return [[self alloc] initWithUrl:url];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
    self.operation = nil;
}

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isLoaded {
    return nil != self.image;
}

- (void)setOperation:(NSOperation *)operation {
    if (_operation != operation) {
        [_operation cancel];
        
        _operation = operation;
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)load {
    @synchronized (self) {
        if (BPVImageLoading == self.state) {
            return;
        }
        
        if (BPVImageLoaded == self.state) {
            [self notifyOfState:BPVImageLoaded];
        }
        
        self.state = BPVImageLoading;
    }
    
    static NSOperationQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [NSOperationQueue new];
        queue.maxConcurrentOperationCount = 2;
    });
    
    __weak BPVImage *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        __strong BPVImage *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
    
        strongSelf.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    }];
    
    operation.completionBlock = ^{
        __strong BPVImage *strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        self.state = self.image ? BPVImageLoaded : BPVImageLoadingFailed;
    };
    
    [queue addOperation:operation];
    
    self.operation = operation;
}

- (void)dump {
    self.operation = nil;
    self.image = nil;
    self.state = BPVImageUnloaded;
}

@end
