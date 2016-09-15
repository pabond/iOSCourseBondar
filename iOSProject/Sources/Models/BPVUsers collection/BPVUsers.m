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
#import "BPVFilteredModel.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, data.plist);
BPVStringConstantWithValue(kBPVModelsFolder, BPVModels);
//BPVConstant(NSUInteger, kBPVSleepTime, 5);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()
@property (nonatomic, copy)     NSString    *applicationFilePath;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
   [self endObservationWithSelectorNames:[self observingSelectorsNames]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.applicationFilePath = [[NSFileManager applicationDataPathWithFolderName:kBPVModelsFolder]
                                    stringByAppendingPathComponent:kBPVApplictionSaveFileName];
        [self startObservationForSelectorNames:[self observingSelectorsNames] block:^{
            [self save];
        }];
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
    BPVWeakify(self)
    [self performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [self addModels:[self arrayModel]];
    }];
    
    self.state = BPVModelDidLoad;
}

#pragma mark -
#pragma mark Private implementations

- (NSArray *)defaultArrayModel {
    return [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id { return [BPVUser new]; }];
}

- (NSArray *)arrayModel {
    NSArray *array = [NSKeyedUnarchiver objectFromFileWithPath:self.applicationFilePath];
    if (array && array.count) {
        NSLog(@"[LOADING] Array will load from file");
    } else {
        array = [self defaultArrayModel];
        NSLog(@"[LOADING] Default array count will load");
    }
    
    return array;
}

- (NSArray *)observingSelectorsNames {
    BPVReturnOnce(NSArray, observers, (^{
        return @[UIApplicationWillTerminateNotification, UIApplicationWillResignActiveNotification];
    }));
}

@end
