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

@dynamic fullName;
@dynamic name;
@dynamic surname;
@dynamic email;
@dynamic userID;
@dynamic birthday;
@dynamic image;
@dynamic friends;
@dynamic imageURL;

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (BPVImage *)image {
    return [BPVImage imageWithUrl:[NSURL URLWithString:self.imageURL]];
}

- (void)setFriends:(NSSet *)friends {
    
    /////////////////////////////
    BPVSetKVCValue(friends, friends);
    
    /////////////////////////
}

@end
