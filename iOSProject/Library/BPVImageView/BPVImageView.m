//
//  BPVImageView.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImageView.h"

#import "BPVImage.h"
#import "BPVGCD.h"

#import "BPVMacro.h"

@implementation BPVImageView

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initSubviews];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initSubviews];
    
    return self;
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                | UIViewAutoresizingFlexibleHeight;
    
    self.imageView = imageView;
}

#pragma mark -
#pragma mark Accessors

- (void)setImage:(BPVImage *)image {
    if (_image != image) {
        [_image removeObserver:self];
        
        _image = image;
        [_image addObserver:self];
        [_image load];
    }
}

- (void)setImageView:(UIImageView *)imageView {
    if (_imageView != imageView) {
        [_imageView removeFromSuperview];
        
        _imageView = imageView;
        [self addSubview:imageView];
    }
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(BPVImage *)model {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.loading = YES;
    });
    
}

- (void)modelDidLoad:(BPVImage *)model {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.imageView.image = model.image;
        
        self.loading = NO;
    });
}

- (void)modelFailLoading:(BPVImage *)model {
    [self.image load];
}

@end
