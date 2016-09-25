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

#import "BPVFriendsListContext.h"

#import "NSFileManager+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, data.plist);
BPVStringConstantWithValue(kBPVModelsFolder, BPVModels);
//BPVConstant(NSUInteger, kBPVSleepTime, 5);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()
@property (nonatomic, readonly) NSString            *applicationFilePath;
@property (nonatomic, strong)   NSMutableDictionary *observers;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;

- (NSArray *)observingSelectorsNames;

- (void)startObservationForNotificationName:(NSString *)name block:(BPVBlock)block;
- (void)startObservationForNotificationNames:(NSArray *)names block:(BPVBlock)block;

- (void)endObservationWithNotificationNames:(NSArray *)names;
- (void)endObservationWithNotificationName:(NSString *)name;

@end

@implementation BPVUsers

@dynamic applicationFilePath;

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
   [self endObservationWithNotificationNames:[self observingSelectorsNames]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observers = [NSMutableDictionary dictionary];
        [self startObservationForNotificationNames:[self observingSelectorsNames] block:^{
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

}

#pragma mark -
#pragma mark Private implementations

- (NSArray *)defaultArrayModel {
    return [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id { return [BPVUser new]; }];
}

- (NSArray *)arrayModel {
    NSArray *array = nil;
    
    BPVFriendsListContext *context = [BPVFriendsListContext new];
    context.userID = self.user.ID;
    context.model = self;
    
    [context execute];
    
    if (array) {
        NSLog(@"[LOADING] Array will load from file");
    } else {
        array = [NSKeyedUnarchiver objectFromFileWithPath:self.applicationFilePath];;
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

- (void)startObservationForNotificationName:(NSString *)name block:(BPVBlock)block {
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                    object:nil
                                                                     queue:nil
                                                                usingBlock:^(NSNotification * _Nonnull note) {
                                                                    BPVPerformBlock(block);
                                                                }];
    
    [self.observers setObject:observer forKey:name];
}

- (void)startObservationForNotificationNames:(NSArray *)names block:(BPVBlock)block {
    for (NSString *name in names) {
        [self startObservationForNotificationName:name block:block];
    }
}

- (void)endObservationWithNotificationNames:(NSArray *)names {
    for (id name in names) {
        [self endObservationWithNotificationName:name];
    }
}

- (void)endObservationWithNotificationName:(NSString *)name {
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    id observer = [self.observers objectForKey:name];
    [notificationCenter removeObserver:observer name:name object:nil];
}

@end
