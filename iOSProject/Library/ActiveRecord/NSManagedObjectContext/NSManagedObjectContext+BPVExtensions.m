//
//  NSManagedObjectContext+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSManagedObjectContext+BPVExtensions.h"

#import "BPVCoreDataManager.h"

#import "BPVMacro.h"

@implementation NSManagedObjectContext (BPVExtensions)

#pragma mark -
#pragma mark Class methods

+ (NSManagedObjectContext *)sharedContext {
    BPVReturnOnce(NSManagedObjectContext, context, ^{
        return [[BPVCoreDataManager sharedManager] managedObjectContext];
    });
}

+ (id)managedObjectWithEntity:(NSString *)entityName {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                         inManagedObjectContext:[self sharedContext]];
    
}

+ (NSArray *)fetchEntity:(NSString *)entityName
     withSortDescriptors:(NSArray *)sortDescriptions
               predicate:(NSPredicate *)predicate
           prefetchPaths:(NSArray *)prefetchPaths
{
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self sharedContext]];
    
    request.returnsObjectsAsFaults = NO;
    request.sortDescriptors = sortDescriptions;
    request.predicate = predicate;
    request.relationshipKeyPathsForPrefetching = prefetchPaths;
    
    return [[self sharedContext] executeFetchRequest:request error:nil];
}

+ (id)objectWithProperty:(id)property
                forValue:(NSString *)valueName
                ofEntity:(NSString *)entityName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"@K like %@", valueName, property];
    NSArray *result = [self fetchEntity:entityName withSortDescriptors:nil predicate:predicate prefetchPaths:nil];
    
    return [result firstObject];
}

+ (void)deleteManagedObject:(NSManagedObject *)object {
    [[self sharedContext] deleteObject:object];
    [self saveManagedObjectContext];
}

+ (void)resetManagedObjectContext {
    [[self sharedContext] reset];
}

+ (void)saveManagedObjectContext {
    NSManagedObjectContext *context = [self sharedContext];
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"%@", error);
        abort();
    }
}

@end
