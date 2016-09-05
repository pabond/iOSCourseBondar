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

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVSleepTime, 3);

@interface BPVImage ()
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, strong) NSURL     *url;

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
        [self load];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors



#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    @synchronized (self) {
        self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
        
        sleep(kBPVSleepTime);
        self.state =  self.image ? BPVModelDidLoad : BPVModelFailLoading;
    }
}

@end
