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

#import "BPVImage.h"

#import "BPVMacro.h"

@implementation BPVUser (CoreDataProperties)

@dynamic name;
@dynamic surname;
@dynamic email;
@dynamic userID;
@dynamic birthday;
@dynamic friends;
@dynamic imageURLString;

@end
