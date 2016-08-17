//
//  BPVImageModelDispatcher.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/17/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImageModelDispatcher.h"

@interface  BPVImageModelDispatcher ()
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)initQueue;

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
#pragma mark Initialasations and deallocations

- (void)dealloc {
    self.queue = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initQueue];
    }
    
    return self;
}

- (void)initQueue {
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    self.queue = queue;
}

#pragma mark -
#pragma mark Accessors

- (void)setQueue:(NSOperationQueue *)queue {
    if (_queue != queue) {
        [_queue cancelAllOperations];
        
        _queue = queue;
    }
}

//- (NSOperationQueue *)queue {
//    static NSOperationQueue *queue = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        queue = [NSOperationQueue new];
//        queue.maxConcurrentOperationCount = 2;
//    });
//    
//    return queue;
//}

@end
