//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"

#import "BPVUser.h"

#import "BPVGCD.h"

#import "NSKeyedArchiver+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()

- (void)loadUsersArray:(NSArray *)array;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Public implementations

- (void)save {
    [NSKeyedArchiver archiveObject:self.models];
}

- (void)load {
    [super load];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObject];
    if (!array) {
        array = [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id{ return [BPVUser new]; }];
    }
    
    [self loadUsersArray:array];
}

#pragma mark -
#pragma mark Private implementations

- (void)loadUsersArray:(NSArray *)array {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        [self addModels:array];
    });
}

@end
