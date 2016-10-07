//
//  NSManagedObjectID+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectID (BPVExtensions)

- (BOOL) isEqualToObjectID:(NSManagedObjectID *)objectID;

@end
