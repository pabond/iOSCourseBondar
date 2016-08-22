//
//  BPVLoadingView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoadingView.h"

@implementation BPVLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = self.window.frame;
    }
    return self;
}

- (void)setLoading:(BOOL)loading {
    if (_loading != loading) {
        _loading = loading;
        
        self.loadingView.hidden = !loading;
    }
}

@end
