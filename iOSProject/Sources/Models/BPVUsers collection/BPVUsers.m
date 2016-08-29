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

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, /data.plist);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@implementation BPVUsers

#pragma mark -
#pragma mark Public implementations

- (NSString *)applicationFilePath {
    static dispatch_once_t onceToken;
    static NSString *path = nil;
    dispatch_once(&onceToken, ^{
        path = [NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName];
    });
    
    return path;
}

- (NSUInteger)defaultModelsCount {
    return kBPVDefaultUsersCount;
}

- (id)newModel {
    return [BPVUser new];
}

@end
