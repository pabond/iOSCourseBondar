//
//  BPVImageModelDispatcher.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImageModelDispatcher.h"

#import "BPVImage.h"
#import "BPVQueue.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVMaxOperationsCount, 2);

@interface  BPVImageModelDispatcher ()
@property (nonatomic, strong) NSOperationQueue  *queue;
@property (nonatomic, assign) NSUInteger        operationsCount;
@property (nonatomic, strong) NSURLSession      *session;

@end

@implementation BPVImageModelDispatcher

#pragma mark -
#pragma mark Class methods

+ (instancetype)shareDespatcher {
    static dispatch_once_t onceToken;
    static id dispatcher = nil;
    dispatch_once(&onceToken, ^{
            dispatcher = [self new];
        });

    return dispatcher;
}

#pragma mark -
#pragma mark Initializaions and deallocations

- (instancetype)init {
    self = [super init];
    self.queue = [NSOperationQueue new];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:self.queue];

    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        _queue = queue;
        
        queue.maxConcurrentOperationCount = kBPVMaxOperationsCount;
    }
}

#pragma mark -
#pragma mark Public Implementations

- (UIImage *)loadImageWithUrl:(NSURL *)url {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url];
    
    return nil;
}

- (void)cancelLoadings {
    [self.session invalidateAndCancel];
}

@end
