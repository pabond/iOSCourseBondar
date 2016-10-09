//
//  BPVUser+CoreDataProperties.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BPVUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPVUser (CoreDataProperties)
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *surname;
@property (nonatomic, copy)     NSString    *imageURL;

@property (nonatomic, copy)     NSString    *email;
@property (nonatomic, copy)     NSString    *userID;
@property (nonatomic, copy)     NSString    *birthday;

@property (nonatomic, readonly) BPVImage    *image;
@property (nonatomic, strong)   NSSet       *friends;

@end

@interface BPVUser (CoreDataGeneratedAccessors)

- (void)addFriend:(BPVUser *)value;
- (void)removeFriend:(BPVUser *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end

NS_ASSUME_NONNULL_END
