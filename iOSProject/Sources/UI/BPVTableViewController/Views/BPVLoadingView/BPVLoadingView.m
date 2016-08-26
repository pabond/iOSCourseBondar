//
//  BPVLoadingView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoadingView.h"

#import "BPVMacro.h"

BPVConstant(CGFloat, kBPVAnimationDuration, 0.5f);
BPVConstant(CGFloat, kBPVUpperAlfa, 0.5f);
BPVConstant(CGFloat, kBPVLowerAlfa, 0.f);

@implementation BPVLoadingView

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
    if (_visible != visible) {
        _visible = visible;
        
        BPVWeakify(self);
        [UIView animateWithDuration:animated ? kBPVAnimationDuration : 0
                         animations:^{
                             BPVStrongify(self);
                             self.alpha = visible ? kBPVUpperAlfa : kBPVLowerAlfa;
                             self.hidden = visible;
                             
                             if (complition) {
                                 complition();
                             }
                         }];
    }
}

- (void)loadingViewInSuperView:(UIView *)superView {
    
}

- (void)showLoadingView {
    [self setVisible:YES animated:YES];
}

- (void)hideLoadingView {
    [self setVisible:NO animated:YES];
}

@end
