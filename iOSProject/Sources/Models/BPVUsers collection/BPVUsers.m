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

#import "NSFileManager+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, /data.plist);
BPVConstant(NSUInteger, kBPVSleepTime, 2);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()
@property (nonatomic, copy) NSString *applicationFilePath;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;
- (void)performLoading;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.applicationFilePath = [NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)save {
    if ([NSKeyedArchiver archiveRootObject:self.models toFile:self.applicationFilePath]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (void)performLoading {
    @synchronized (self) {
        NSArray *array = [self arrayModel];
        
        BPVWeakify(self)
        [self performBlockWithoutNotification:^{
            BPVStrongifyAndReturnIfNil(self)
            [self addModels:array];
        }];
        
        sleep(kBPVSleepTime);
        BPVPerformAsyncBlockOnMainQueue(^{
            BPVStrongifyAndReturnIfNil(self)
            self.state = BPVModelDidLoad;
        });
    }
}

#pragma mark -
#pragma mark Private implementations

- (NSArray *)defaultArrayModel {
    return [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id { return [BPVUser new]; }];
}

- (NSArray *)arrayModel {
    NSArray *array = [NSKeyedUnarchiver objectFromFileWithFilePath:self.applicationFilePath];
    
    if (array) {
        NSLog(@"[LOADING] Array will load from file");
    } else {
        array = [self defaultArrayModel];
        NSLog(@"[LOADING] Default array count will load");
    }
    
    return array;
}


@end
