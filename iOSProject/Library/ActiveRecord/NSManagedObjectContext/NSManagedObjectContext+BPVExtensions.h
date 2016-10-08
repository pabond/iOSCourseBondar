//
//  NSManagedObjectContext+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (BPVExtensions)

+ (NSManagedObjectContext *)sharedContext;

+ (id)managedObjectWithEntity:(NSString *)entityName;

+ (NSArray *)fetchEntity:(NSString *)entityName
     withSortDescriptors:(NSArray *)sortDescriptions
               predicate:(NSPredicate *)predicate
           prefetchPaths:(NSArray *)prefetchPaths;

+ (id)objectWithProperty:(id)property
                forValue:(NSString *)valueName
                ofEntity:(NSString *)entityName;

+ (void)deleteManagedObject:(NSManagedObject *)object;
+ (void)resetManagedObjectContext;
+ (void)saveManagedObjectContext;

@end
