//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"

#import "NSKeyedArchiver+BPVExtensions.h"

@implementation BPVUsers

- (void)save {
    [NSKeyedArchiver archiveObject:self.models];
}

@end
