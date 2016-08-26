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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setVisible:(BOOL)visible {
    [self setVisible:visible animated:NO];
}

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
                             
                             if (complition) {
                                 complition();
                             }
        }];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)showLoadingView {
    BPVWeakify(self);
    [self setVisible:YES animated:YES complitionHandler:^{
        BPVStrongify(self);
        if (self.stopLoading == YES) {
            return;
        }
    }];
}

@end
