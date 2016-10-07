//
//  BPVUser+CoreDataProperties.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BPVUser+CoreDataProperties.h"

#import "BPVMacro.h"

@implementation BPVUser (CoreDataProperties)

@dynamic fullName;
@dynamic name;
@dynamic surname;
@dynamic email;
@dynamic userID;
@dynamic birthday;
@dynamic images;
@dynamic friends;

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (void)setName:(NSString *)name {
    [self setValue:name forKey:NSStringFromSelector(@selector(name))];
}

- (NSString *)name {
    return [self valueForKey:NSStringFromSelector(@selector(name))];
}

@end
