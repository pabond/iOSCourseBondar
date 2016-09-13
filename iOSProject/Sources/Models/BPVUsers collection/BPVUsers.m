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
//BPVConstant(NSUInteger, kBPVSleepTime, 5);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVUsers ()
@property (nonatomic, strong)   id          observer;
@property (nonatomic, copy)     NSString    *applicationFilePath;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;

@end

@implementation BPVUsers

#pragma mark -
#pragma mark Initializationa and deallocations

- (void)dealloc {
   [self endObservation];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.applicationFilePath = [NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName];
//        [self startObservation];
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

//- (void)startObservation {
//    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification
//                                                                      object:nil
//                                                                       queue:nil
//                                                                  usingBlock:^(NSNotification * _Nonnull note) {
//                                                                      <#code#>
//                                                                  }];
//    
//    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification
//                                                                      object:nil
//                                                                       queue:nil
//                                                                  usingBlock:^(NSNotification * _Nonnull note) {
//                                                                      
//                                                                  }];
//    
//}

- (void)endObservation {
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
}

@end
