//
//  NSManagedObject+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (BPVExtensions)

+ (NSArray *)fetchEntityWithSortDescriptors:(NSArray *)sortDescriptors
                                  predicate:(NSPredicate *)predicate
                              prefatchPaths:(NSArray *)prefetchPaths;

+ (id)managedObject;

- (void)deleteManagedObject;
- (void)saveManagedObject;

- (void)setCustomValue:(id)value forKey:(NSString *)key;
- (id)customValueForKey:(NSString *)key;

- (void)addCustomValue:(id)value forKey:(NSString *)key;
- (void)removeCustomValue:(id)value forKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values forKey:(NSString *)key;
- (void)removeCustomValues:(NSSet *)values forKey:(NSString *)key;

- (void)addCustomValues:(NSSet *)values inMutableOrderedSetForKey:(NSString *)key;
- (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key;

@end
