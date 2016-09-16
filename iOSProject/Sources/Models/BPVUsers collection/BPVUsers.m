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
@property (nonatomic, readonly)     NSString        *applicationFilePath;
@property (nonatomic, strong)   NSMutableArray  *observers;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;

- (NSArray *)observingSelectorsNames;

- (void)startObservationForSelectorName:(NSString *)name block:(BPVBlock)block;
- (void)startObservationForSelectorNames:(NSArray *)names block:(BPVBlock)block;

- (void)endObservationWithSelectorNames:(NSArray *)names;
- (void)endObservationWithSelectorName:(NSString *)name;

@end

@implementation BPVUsers

@dynamic applicationFilePath;

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
   [self endObservationWithSelectorNames:[self observingSelectorsNames]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self startObservationForSelectorNames:[self observingSelectorsNames] block:^{
            [self save];
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)applicationFilePath {
    NSString *modelsFolderPath = [NSFileManager applicationDataPathWithFolderName:kBPVModelsFolder];
    
    return [modelsFolderPath stringByAppendingPathComponent:kBPVApplictionSaveFileName];
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

#pragma mark -
#pragma mark Observation methods

- (NSArray *)observingSelectorsNames {
    BPVReturnOnce(NSArray, observers, (^{
        return @[UIApplicationWillTerminateNotification, UIApplicationWillResignActiveNotification];
    }));
}

- (void)startObservationForSelectorName:(NSString *)name block:(BPVBlock)block {
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                    object:nil
                                                                     queue:nil
                                                                usingBlock:^(NSNotification * _Nonnull note) {
                                                                    BPVPerformBlock(block);
                                                                }];
    
    [self.observers addObject:observer];
}

- (void)startObservationForSelectorNames:(NSArray *)names block:(BPVBlock)block {
    for (NSString *name in names) {
        [self startObservationForSelectorName:name block:block];
    }
}

- (void)endObservationWithSelectorNames:(NSArray *)names {
    for (id name in names) {
        [self endObservationWithSelectorName:name];
    }
}

- (void)endObservationWithSelectorName:(NSString *)name {
    for (id observer in self.observers) {
        if ([observer respondsToSelector:@selector(name)]) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:nil];
        }
    }
}

@end
