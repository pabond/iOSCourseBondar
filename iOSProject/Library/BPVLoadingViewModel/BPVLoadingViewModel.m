//
//  BPVLoadingViewModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoadingViewModel.h"

#import "NSBundle+BPVExtensions.h"

@implementation BPVLoadingViewModel

#pragma mark -
#pragma mark Class Methods

+ (id)loadingViewInSuperView:(UIView *)superView {
    BPVLoadingViewModel *loadingView = [NSBundle objectWithClass:[self class]];
    loadingView.frame = superView.bounds;
    loadingView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleHeight;
    
    return loadingView;
}

#pragma mark -
#pragma mark Accessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:NO];
}

#pragma mark -
#pragma mark Public implementations

- (void)setVisible:(BOOL)visible animated:(BOOL)animated {
    [self setVisible:visible animated:animated complitionHandler:nil];
}

- (void)setVisible:(BOOL)visible animated:(BOOL)animated complitionHandler:(BPVHandler)complition {

}

@end
