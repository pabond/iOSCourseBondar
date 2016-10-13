//
//  BPVCDArrayModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCDArrayModel.h"

#import "BPVUser.h"

#import <CoreData/CoreData.h>
#import "BPVCoreDataManager.h"

#import "NSManagedObject+BPVExtensions.h"
#import "NSManagedObjectContext+BPVExtensions.h"

#import "BPVMacro.h"

static NSFetchedResultsController *__fetchedResultsController = nil;
BPVConstant(NSUInteger, kBPVBatchSize, 20);

@interface BPVCDArrayModel ()
@property (nonatomic, strong)   NSFetchedResultsController          *fetchedResultsController;
@property (nonatomic, strong)   NSSet                               *modelsSet;
@property (nonatomic, weak)     id <BPVObservableObjectProtocol>    object;

@end

@implementation BPVCDArrayModel

+ (instancetype)CDArrayModelWithObject:(id <BPVObservableObjectProtocol>)object {
    return [[self alloc] initWithObject:object];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithObject:(id <BPVObservableObjectProtocol>)object {
    self = [super init];
    self.fetchedResultsController = [self fetchedResultsController];
    
    return self;
}
- (NSFetchedResultsController *)fetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([BPVUser class])];
    [fetchRequest setFetchBatchSize:kBPVBatchSize];
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"userID" ascending:NO]];
    fetchRequest.predicate = self.predicate;

    __fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                     managedObjectContext:[NSManagedObjectContext sharedContext]
                                                                       sectionNameKeyPath:nil
                                                                                cacheName:nil];
    
    NSError *error = nil;
    if (![__fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __fetchedResultsController;
}

#pragma mark -
#pragma mark Accessors

- (NSPredicate *)predicate {
    return nil;
}

- (NSSortDescriptor *)sortDesriptor {
    return nil;
}

#pragma mark -
#pragma mark Public implementations

- (void)addModel:(id)model {
    
}

- (void)removeModel:(id)model {

}

- (void)addModels:(NSArray *)models {

}

- (id)modelAtIndex:(NSUInteger)index {

}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    return;
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    return;
}

- (BOOL)containsModel:(id)model {

}

- (void)removeModelAtIndex:(NSUInteger)index {

}

- (NSUInteger)indexOfModel:(id)model {

}

- (id)objectAtIndexedSubscript:(NSUInteger)index {

}

@end
