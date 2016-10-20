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

#import "NSArray+BPVExtensions.h"
#import "NSManagedObject+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVBatchSize, 20);
BPVStringConstant(kBPVMaster);
BPVStringConstantWithValue(kBPVUserID, userID);

@interface BPVCDArrayModel ()
@property (nonatomic, strong)   NSFetchedResultsController  *fetchedResultsController;
@property (nonatomic, copy)     NSString                    *keyPath;
@property (nonatomic, weak)     NSManagedObject             *object;

@end

@implementation BPVCDArrayModel

@dynamic sortDesriptor;
@dynamic batchSize;
@dynamic predicate;

#pragma mark -
#pragma mark Class methods

+ (instancetype)coreDataArrayModelWithObject:(id <BPVObservableObject>)object keyPath:(NSString *)keyPath {
    return [[self alloc] initWithObject:object keyPath:keyPath];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithObject:(NSManagedObject *)object keyPath:(NSString *)keyPath {
    self = [super init];
    self.object = object;
    self.keyPath = keyPath;
    self.fetchedResultsController = [self controller];
    
    return self;
}

- (NSFetchedResultsController *)controller {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([[self.object class] class])];
    fetchRequest.fetchBatchSize = [self batchSize];
    
    fetchRequest.sortDescriptors = self.sortDesriptors;
    fetchRequest.predicate = self.predicate;
    
    NSManagedObjectContext *context = self.object.managedObjectContext;
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:kBPVMaster];
    
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
    return [NSPredicate predicateWithFormat:@"%K contains %@", self.keyPath, self.object];
}

- (NSArray<NSSortDescriptor *> *)sortDesriptors {
    return @[[[NSSortDescriptor alloc] initWithKey:kBPVUserID ascending:NO]];
}

- (NSUInteger)batchSize {
    return kBPVBatchSize;
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%@", [error userInfo]);
    }
    
    self.state = !error ? BPVModelDidLoad : BPVModelFailLoading;
}

- (void)addModel:(NSManagedObject *)model {
    @synchronized (self) {
        [self.object addCustomValue:model forKey:self.keyPath];
    }
}

- (void)removeModel:(NSManagedObject *)model {
    @synchronized (self) {
        if ([self containsModel:model]) {
            [self.object removeCustomValue:model forKey:self.keyPath];
        }
    }
}

- (id)modelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        return self.fetchedResultsController.fetchedObjects[index];
    }
}

- (BOOL)containsModel:(NSManagedObject *)model {
    @synchronized (self) {
        NSArray *array = [self.fetchedResultsController.fetchedObjects filteredUsingBlock:^BOOL(NSManagedObject *object) {
            return [object.objectID isEqual:model.objectID];
        }];
        
        return (BOOL)array.count;
    }
}

- (NSUInteger)indexOfModel:(id)model {
    @synchronized (self) {
        return [[self models] indexOfObject:model];
    }
}

- (NSUInteger)count {
    @synchronized (self) {
        return self.models.count;
    }
}

- (NSArray *)models {
    @synchronized (self) {
        return self.fetchedResultsController.fetchedObjects;
    }
}

- (void)removeModelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        NSManagedObject *object = [self modelAtIndex:index];
        if (object) {
            [self removeModel:object];
        }
    }
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
    @synchronized (self) {
        return [self.fetchedResultsController.fetchedObjects countByEnumeratingWithState:state
                                                                                 objects:buffer
                                                                                   count:length];
    }
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
    NSUInteger index = indexPath.row;
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            object = [BPVArrayChange addModelWithIndex:index object:anObject];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            object = [BPVArrayChange removeModelWithIndex:index object:anObject];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            object = [BPVArrayChange moveModelWithIndex:newIndexPath.row
                                              fromIndex:index
                                                 object:anObject];
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            object = [BPVArrayChange updateModelWithIndex:index object:anObject];
            break;
        }
            
        default:
            break;
    }
    
    [self notifyOfArrayChangeWithObject:object];
}

@end
