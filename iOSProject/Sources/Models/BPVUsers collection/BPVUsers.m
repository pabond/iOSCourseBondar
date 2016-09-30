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

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVApplictionSaveFileName, data.plist);
BPVStringConstantWithValue(kBPVFriends, friends);
BPVStringConstantWithValue(kBPVPlist, plist);

@interface BPVUsers ()
@property (nonatomic, strong)   NSMutableDictionary *observers;
@property (nonatomic, assign)   NSString            *userID;

- (instancetype)initWithUserID:(NSString *)userID;

- (NSArray *)observingSelectorsNames;

- (void)startObservationForNotificationName:(NSString *)name block:(BPVBlock)block;
- (void)startObservationForNotificationNames:(NSArray *)names block:(BPVBlock)block;

- (void)endObservationWithNotificationNames:(NSArray *)names;
- (void)endObservationWithNotificationName:(NSString *)name;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Class methods

+ (instancetype)friendsWithUserID:(NSString *)userID {
    return [[[self class] alloc] initWithUserID:userID];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUserID:(NSString *)userID {
    self = [super init];
    self.observers = [NSMutableDictionary dictionary];
    self.userID = userID;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)filePath {
    NSString *fileName = [NSString stringWithFormat:@"%@%@.%@", self.userID, kBPVFriends, kBPVPlist];
    NSString *path = [self.applicationModelsPath stringByAppendingPathComponent:fileName];
    
    return path;
}

#pragma mark -
#pragma mark Public implementations

- (void)save {
    if ([NSKeyedArchiver archiveRootObject:self.models toFile:self.filePath]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
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
