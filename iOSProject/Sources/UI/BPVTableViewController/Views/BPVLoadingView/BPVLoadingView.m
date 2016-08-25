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

- (void)setLoading:(BOOL)loading {
    [self setLoading:loading animated:NO];
}

- (void)setLoading:(BOOL)loading animated:(BOOL)animated {
    [self setLoading:loading animated:animated complitionHandler:nil];
}

- (void)setLoading:(BOOL)loading animated:(BOOL)animated complitionHandler:(BPVHandler)complition {
    if (_loading != loading) {
        _loading = loading;
        
        BPVWeakify(self);
        [UIView animateWithDuration:animated ? kBPVAnimationDuration : 0
                         animations:^{
                             BPVStrongify(self);
                             self.alpha = loading ? kBPVUpperAlfa : kBPVLowerAlfa;
                             
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
    [self setLoading:YES animated:YES complitionHandler:^{
        BPVStrongify(self);
        if (self.stopLoading == YES) {
            return;
        }
    }];
}

@end
