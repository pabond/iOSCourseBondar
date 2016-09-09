//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVView.h"
#import "BPVImage.h"
#import "BPVGCD.h"

#import "BPVMacro.h"

@interface BPVUserCell ()
@property (nonatomic, strong) BPVImage *image;

@end

@implementation BPVUserCell

#pragma mark - 
#pragma mark Accessors

- (void)setImage:(BPVImage *)image {
    if (_image != image) {
        [_image removeObserver:self];
        
        _image = image;
        [_image addObserver:self];
        [image load];
    }
}

- (void)setUser:(BPVUser *)user {
    if (_user != user) {        
        _user = user;
        
        [self fillWithModel:_user];
    }
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillWithModel:(BPVUser *)user {
    self.userNameLabel.text = self.user.fullName;
    self.image = user.image;
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(BPVImage *)model {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.contentLoadingView.loading = YES;
    });
   
}

- (void)modelDidLoad:(BPVImage *)model {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.userImageView.image = self.image.image;
        self.contentLoadingView.loading = NO;
    });
}

- (void)modelFailLoading:(BPVImage *)model {
    [model load];
}

@end
