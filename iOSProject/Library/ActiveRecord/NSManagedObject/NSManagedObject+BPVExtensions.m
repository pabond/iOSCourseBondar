//
//  NSManagedObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSManagedObject+BPVExtensions.h"

#import "BPVMacro.h"

@implementation NSManagedObject (BPVExtensions)

+ (NSArray *)fetchEntityWithSortDescriptors:(NSArray *)sortDescriptors
                                  predicate:(NSPredicate *)predicate
                              prefatchPaths:(NSArray *)prefetchPaths
{
    return [NSManagedObjectContext fetchEntity:NSStringFromClass([self class])
                             withSortDesripors:sortDescriptors
                                     predicate:predicate
                                 prefetchPaths:prefetchPaths];
}

+ (id)managedObject {
    return [NSManagedObjectContext managedObjectWithEntity:NSStringFromClass([self class])];
}

- (void)deleteManagedObject {
    [NSManagedObjectContext deleteManagedObject:self];
}

- (void)saveManagedObject {
    [NSManagedObjectContext saveManagedObjectContext];
}

- (void)setCustomValue:(id)value forKey:(NSString *)key {
    [self willChangeValueForKey:key];
    [self setPrimitiveValue:value forKey:key];
    [self didChangeValueForKey:key];
}

- (id)customValueForKey:(NSString *)key {
    [self willAccessValueForKey:key];
    id result = [self primitiveValueForKey:key];
    [self didAccessValueForKey:key];
    
    return result;
}

- (void)addCustomValue:(id)value forKey:(NSString *)key {
    [self addCustomValues:[[NSSet alloc] initWithObjects:&value count:1] forKey:key];
}

- (void)removeCustomValue:(id)value forKey:(NSString *)key {
    [self removeCustomValues:[[NSSet alloc] initWithObjects:&value count:1] forKey:key];
}

- (void)addCustomValues:(NSSet *)values forKey:(NSString *)key {
    [self willChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    [primitiveSet unionSet:values];
    [self didChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
}

- (void)removeCustomValues:(NSSet *)values forKey:(NSString *)key {
    [self willChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    [primitiveSet minusSet:values];
    [self didChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
}

- (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key {
    [[self primitiveValueForKey:key] addObject:value];
}

@end
