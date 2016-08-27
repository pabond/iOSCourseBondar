//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"

@implementation BPVUsers

#pragma mark -
#pragma mark Public implementations

- (void)load {
    if (self.state != BPVArrayModelUnload) {
        return;
    }
    
    [super load];
}

@end
