//
//  BPVCDUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCDUsers.h"

@implementation BPVCDUsers

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithFormat:@"%@ contains %@", self.keyPath, self.models];
}

@end
