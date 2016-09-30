//
//  BPVUser.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUser.h"

#import "BPVImage.h"
#import "BPVGCD.h"

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

BPVStringConstantWithValue(kBPVPlist, plist);

@implementation BPVUser

@dynamic image;

@dynamic fullName;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (BPVImage *)image {
    return [BPVImage imageWithUrl:self.imageURL];
}

- (NSString *)filePath {
    NSString *fileName = [NSString stringWithFormat:@"%@.%@", self.ID, kBPVPlist];
    NSString *path = [self.applicationModelsPath stringByAppendingPathComponent:fileName];
    
    return path;
}

#pragma mark -
#pragma mark Public implemantations

- (void)save {
    if ([NSKeyedArchiver archiveRootObject:self toFile:self.filePath]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelDidLoadID:
            return @selector(modelDidLoadID:);
            
        case BPVModelDidLoadDetailedInfo:
            return @selector(modelDidLoadDetailedInfo:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kBPVUserName];
    [aCoder encodeObject:self.surname forKey:kBPVUserSurname];
    
    [aCoder encodeObject:self.email forKey:kBPVUserEmail];
    [aCoder encodeObject:self.birthday forKey:kBPVUserBirthday];
    
    [aCoder encodeObject:self.ID forKey:kBPVUserID];
    [aCoder encodeObject:self.imageURL forKey:kBPVUserURL];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:kBPVUserName];
        self.surname = [aDecoder decodeObjectForKey:kBPVUserSurname];
        
        self.imageURL = [aDecoder decodeObjectForKey:kBPVUserURL];
        self.email = [aDecoder decodeObjectForKey:kBPVUserEmail];
        
        self.birthday = [aDecoder decodeObjectForKey:kBPVUserBirthday];
        self.ID = [aDecoder decodeObjectForKey:kBPVUserID];
    }
    
    return self;
}

@end
