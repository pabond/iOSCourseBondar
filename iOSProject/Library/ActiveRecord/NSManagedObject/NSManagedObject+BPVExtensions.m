//
//  NSManagedObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSManagedObject+BPVExtensions.h"

#import "NSManagedObjectContext+BPVExtensions.h"

#import "BPVMacro.h"

typedef void(^BPVBlock)();

@implementation NSManagedObject (BPVExtensions)

#pragma mark -
#pragma mark Class methods

+ (NSArray *)entitisWithSortDescriptors:(NSArray *)sortDescriptors
                              predicate:(NSPredicate *)predicate
                          prefatchPaths:(NSArray *)prefetchPaths
{
    return [NSManagedObjectContext entity:BPVClassString
                      withSortDescriptors:sortDescriptors
                                predicate:predicate
                            prefetchPaths:prefetchPaths];
}

+ (id)managedObject {
    return [NSManagedObjectContext managedObjectWithEntity:BPVClassString];
}

#pragma mark -
#pragma mark Public Implementations

- (void)removeManagedObject {
    [NSManagedObjectContext removeManagedObject:self];
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
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    [self changeValues:values forKey:key withBlock:^{
        [primitiveSet unionSet:values];
    }];
}

- (void)removeCustomValues:(NSSet *)values forKey:(NSString *)key {
    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
    [self changeValues:values forKey:key withBlock:^{
        [primitiveSet minusSet:values];
    }];
}

- (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key {
    [[self primitiveValueForKey:key] addObject:value];
}

- (void)changeValues:(NSSet *)values forKey:(NSString *)key withBlock:(BPVBlock)block {
    if (!block) {
        return;
    }
    
    [self willChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
    block();
    [self didChangeValueForKey:key withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
}

@end
