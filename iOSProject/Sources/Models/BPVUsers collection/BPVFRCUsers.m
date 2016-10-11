//
//  BPVFRCUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFRCUsers.h"

#import "BPVUser.h"

#import <CoreData/CoreData.h>
#import "BPVCoreDataManager.h"

@interface BPVFRCUsers ()
@property (nonatomic, strong) NSFetchedResultsController *controller;

@end

@implementation BPVFRCUsers

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)init {
    self = [super init];
    [self initController];
    
    return self;
}

- (void)initController {
    BPVCoreDataManager *manager = [BPVCoreDataManager sharedManager];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([BPVUser class])];
    
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                          managedObjectContext:manager.managedObjectContext
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
}

#pragma mark -
#pragma mark Public implementations

- ()

@end
