//
//  BPVImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

#import "BPVImageModelDispatcher.h"

#import "BPVMacro.h"

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
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors



#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    self.image = [UIImage imageWithContentsOfFile:[self.url absoluteString]];
    self.state = self.image ? BPVModelDidLoad : BPVModelFailLoading;
}

#pragma mark -
#pragma mark Private implementations

@end
