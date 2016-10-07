//
//  NSManagedObjectContext+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (BPVExtensions)

+ (id)managedObjectWithEntity:(NSString *)entityName;

+ (NSArray *)fetchEntity:(NSString *)entityName
     withSortDescriptors:(NSArray *)sortDescriptions
               predicate:(NSPredicate *)predicate
           prefetchPaths:(NSArray *)prefetchPaths;

+ (id)getObjectWithName:(NSString *)name
               forValue:(NSString *)valueName
               ofEntity:(NSString *)entityName;

+ (id)getObjectWithProperty:(id)property
                   forValue:(NSString *)valueName
                   ofEntity:(NSString *)entityName;

+ (id)managedObjectWithManagedObjectIDURL:(NSURL *)url;
+ (id)managedObjectWithManagedObjectID:(NSManagedObjectID *)managedObjectID;

+ (void)deleteManagedObject:(NSManagedObject *)object;
+ (void)resetManagedObjectContext;
+ (void)saveManagedObjectContext;

@end
