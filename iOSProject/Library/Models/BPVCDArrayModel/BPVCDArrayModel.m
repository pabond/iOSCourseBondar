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
#import "BPVArrayChange.h"

#import "NSManagedObject+BPVExtensions.h"
#import "NSManagedObjectContext+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVBatchSize, 20);
BPVStringConstant(kBPVMaster);
BPVStringConstantWithValue(kBPVUserID, userID);

@interface BPVCDArrayModel ()
@property (nonatomic, strong)   NSFetchedResultsController          *fetchedResultsController;
@property (nonatomic, weak)     id <BPVObservableObjectProtocol>    object;
@property (nonatomic, copy)     NSString                            *keyPath;

@end

@implementation BPVCDArrayModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)CDArrayModelWithObject:(id <BPVObservableObjectProtocol>)object keyPath:(NSString *)keyPath {
    return [[self alloc] initWithObject:object];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithObject:(id <BPVObservableObjectProtocol>)object keyPath:(NSString *)keyPath {
    self = [super init];
    self.fetchedResultsController = [self controller];
    self.keyPath = keyPath;
    
    return self;
}

- (NSFetchedResultsController *)controller {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([BPVUser class])];
    fetchRequest.fetchBatchSize = kBPVBatchSize;
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:kBPVUserID ascending:NO]];
    fetchRequest.predicate = self.predicate;
    
    NSManagedObjectContext *context = [NSManagedObjectContext sharedContext];
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:kBPVMaster];
    
    NSError *error = nil;
    if (![controller performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return controller;
}

#pragma mark -
#pragma mark Accessors

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != fetchedResultsController) {
        _fetchedResultsController = fetchedResultsController;
        
        _fetchedResultsController.delegate = self;
    }
}

- (NSPredicate *)predicate {
    return nil;
}

- (NSSortDescriptor *)sortDesriptor {
    return nil;
}

#pragma mark -
#pragma mark Public implementations

- (id)modelAtIndex:(NSUInteger)index {
    return self.fetchedResultsController.fetchedObjects[index];
}

- (BOOL)containsModel:(NSManagedObject *)model {
    NSArray *array = [self.fetchedResultsController.fetchedObjects filteredUsingBlock:^BOOL(NSManagedObject *object) {
        return [object.objectID isEqual:model.objectID];
    }];
    
    return (BOOL)array.count;
}

- (NSUInteger)indexOfModel:(id)model {
    return [self.fetchedResultsController.fetchedObjects indexOfObject:model];
}

- (NSUInteger)count {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (NSArray *)models {
    return self.fetchedResultsController.fetchedObjects;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    return;
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    return;
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)length
{
    return [self.fetchedResultsController.fetchedObjects countByEnumeratingWithState:state
                                                                             objects:buffer
                                                                               count:length];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    BPVArrayChange *object = nil;
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            object = [BPVArrayChange addModelWithIndex:indexPath.row object:anObject];
        }
            
        case NSFetchedResultsChangeDelete: {
            object = [BPVArrayChange removeModelWithIndex:indexPath.row object:anObject];
        }
            
        case NSFetchedResultsChangeMove: {
            object = [BPVArrayChange moveModelWithIndex:newIndexPath.row
                                              fromIndex:indexPath.row
                                                 object:anObject];
        }
            
        case NSFetchedResultsChangeUpdate: {
            object = [BPVArrayChange updateModelWithIndex:indexPath.row object:anObject];
        }
            
        default:
            break;
    }
    
    [self notifyOfArrayChangeWithObject:object];
}

@end
