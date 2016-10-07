//
//  NSManagedObjectID+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSManagedObjectID+BPVExtensions.h"

@implementation NSManagedObjectID (BPVExtensions)

- (BOOL) isEqualToObjectID:(NSManagedObjectID *)objectID {
    return [[self URIRepresentation] isEqual:[objectID URIRepresentation]];
}

@end
