//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"

#import "BPVUser.h"

#import "NSFileManager+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, /data.plist);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()

- (NSArray *)defaultArrayModel;
- (NSString *)applicationFilePath;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Public implementations

- (void)save {
    if ([NSKeyedArchiver archiveRootObject:self.models toFile:[self applicationFilePath]]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (NSArray *)arrayModel {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[self applicationFilePath]]];
    
    if (array) {
        NSLog(@"[LOADING] Array will load from file");
    } else {
        array = [self defaultArrayModel];
        NSLog(@"[LOADING] Default array count will load");
    }
    
    return array;
}

#pragma mark -
#pragma mark Private implementations

- (NSArray *)defaultArrayModel {
    return [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id { return [BPVUser new]; }];
}

- (NSString *)applicationFilePath {
    BPVOnce(NSString, path, ^{ return [NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName]; });
}

@end
