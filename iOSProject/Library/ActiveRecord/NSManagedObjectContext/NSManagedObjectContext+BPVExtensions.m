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
    BPVCoreDataManager *manager = [BPVCoreDataManager sharedManager];
    NSManagedObjectContext *managedObjectContext = [manager managedObjectContext];
        
    return managedObjectContext;
}

+ (id)managedObjectWithEntity:(NSString *)entityName {
    NSManagedObjectContext *context = [self sharedContext];
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
}

+ (NSArray *)entity:(NSString *)entityName
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
    NSArray *result = [self entity:entityName withSortDescriptors:nil predicate:predicate prefetchPaths:nil];
    
    return [result firstObject];
}

+ (void)removeManagedObject:(NSManagedObject *)object {
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
