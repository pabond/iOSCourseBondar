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

- (void)setLoading:(BOOL)loading {
    if (_loading != loading) {
        _loading = loading;
        
        self.hidden = !loading;
        
        BPVWeakify(self);
        [UIView animateWithDuration:kBPVAnimationDuration animations:^{
            BPVStrongify(self);
            self.alpha = loading ? kBPVUpperAlfa : kBPVLowerAlfa;
        }];
    }
}

@end
