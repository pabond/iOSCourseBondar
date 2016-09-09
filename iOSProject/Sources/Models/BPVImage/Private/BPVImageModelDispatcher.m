//
//  BPVImageModelDispatcher.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/17/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImageModelDispatcher.h"

#import "BPVImage.h"
#import "BPVQueue.h"

#import "BPVMacro.h"

@interface  BPVImageModelDispatcher ()
//@property (nonatomic, strong) BPVQueue              *queue;
@property (nonatomic, assign) NSUInteger            operationsCount;
@property (nonatomic, strong) NSMutableDictionary   *images;

@end

@implementation BPVImageModelDispatcher

BPVConstant(NSUInteger, BPVMaxOperationsCount, 2);

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
    if (self) {
        self.queue = [BPVQueue new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public implementaions

- (void)loadImage:(BPVImage *)image {
    @synchronized (self) {
        if (self.operationsCount < BPVMaxOperationsCount) {
            [image load];
        } else {
            [self.queue enqueueObject:image];
        }
    }
}

#pragma mark -
#pragma mark Private implementaions

- (void)performNextImageLoading {
    BPVQueue *queue = self.queue;
    
    @synchronized (self) {
        if (queue.count) {
            BPVImage *image = [queue dequeueObject];
            [image load];
        }
    }
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoad:(BPVImage *)model {
    @synchronized (self) {
        [self performNextImageLoading];
    }
}

- (void)modelFailLoading:(BPVImage *)model {
    @synchronized (self) {
        [model load];
    }
}

@end
