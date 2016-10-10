//
//  BPVUser.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUser.h"

#import "BPVUsers.h"
#import "BPVImage.h"

@implementation BPVUser

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    self.friends = [NSSet set];
    
    return self;
}

@end
