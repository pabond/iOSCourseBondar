//
//  BPVUser.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUser.h"

#import "BPVUsers.h"
#import "BPVImage.h"
#import "BPVGCD.h"

#import "BPVCDUsers.h"

#import "NSString+BPVRandomName.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVUserName, userName);
BPVStringConstantWithValue(kBPVUserSurname, userSurname);

BPVStringConstantWithValue(kBPVUserURL, userURL);
BPVStringConstantWithValue(kBPVUserID, userID);

BPVStringConstantWithValue(kBPVUserBirthday, userBirthday);
BPVStringConstantWithValue(kBPVUserEmail, userEmail);

BPVStringConstantWithValue(kBPVUserImageName, BPVUserLogo);
BPVStringConstantWithValue(kBPVUserImageFormat, png);

@interface BPVUser ()
@property (nonatomic, strong)   BPVObservableObject *observableObject;
@property (nonatomic, strong)   BPVArrayModel       *arrayModel;

@end

@implementation BPVUser

@dynamic fullName;
@dynamic image;

#pragma mark -
#pragma mark Initializations and deallocations

- (NSManagedObject *)initWithEntity:(NSEntityDescription *)entity
     insertIntoManagedObjectContext:(nullable NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.arrayModel = [BPVCDUsers CDArrayModelWithObject:self keyPath:BPVStringFromSEL(friends)];
    self.observableObject = [BPVObservableObject observableObjectWithTarget:self];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (BPVImage *)image {
    return [BPVImage imageWithUrl:[NSURL URLWithString:self.imageURLString]];
}

#pragma mark -
#pragma mark Public implemantations

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.observableObject;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelDidLoadID:
            return @selector(modelDidLoadID:);
            
        case BPVModelDidLoadDetailedInfo:
            return @selector(modelDidLoadDetailedInfo:);
            
        case BPVModelWillLoadDetailedInfo:
            return @selector(modelWillLoadDetailedInfo:);
            
        case BPVModelFailLoadingDetailedInfo:
            return @selector(modelFailLoadingDetailedInfo:);

        default:
            return [self.observableObject selectorForState:state];
    }
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kBPVUserName];
    [aCoder encodeObject:self.surname forKey:kBPVUserSurname];
    
    [aCoder encodeObject:self.email forKey:kBPVUserEmail];
    [aCoder encodeObject:self.birthday forKey:kBPVUserBirthday];
    
    [aCoder encodeObject:self.userID forKey:kBPVUserID];
    [aCoder encodeObject:self.imageURLString forKey:kBPVUserURL];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:kBPVUserName];
        self.surname = [aDecoder decodeObjectForKey:kBPVUserSurname];
        
        self.imageURLString = [aDecoder decodeObjectForKey:kBPVUserURL];
        self.email = [aDecoder decodeObjectForKey:kBPVUserEmail];
        
        self.birthday = [aDecoder decodeObjectForKey:kBPVUserBirthday];
        self.userID = [aDecoder decodeObjectForKey:kBPVUserID];
    }
    
    return self;
}

@end
