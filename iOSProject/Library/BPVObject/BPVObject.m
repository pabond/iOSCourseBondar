//
//  BPVObject.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObject.h"

#import "BPVMacro.h"
#import "BPVCoreDataManager.h"

@implementation BPVObject

+ (instancetype)objectWithPredicate:(NSPredicate *)predicat {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    fetchRequest.predicate = predicat;
    
    NSManagedObjectContext *context = [[BPVCoreDataManager sharedManager] managedObjectContext];
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    return [objects firstObject];
}

@end
