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
BPVStringConstantWithValue(kBPVUserImageName, BPVUserLogo);
BPVStringConstantWithValue(kBPVUserImageFormat, png);
static NSString * const kBPVImageURL = @"http://denderi.lv/wp-content/uploads/2015/12/ziemelbriedis.png";

@interface BPVUser ()
@property (nonatomic, strong) NSURL *url;

@end

@implementation BPVUser

@dynamic image;

@dynamic fullName;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    
    self.name = [NSString randomName];
    self.surname = [NSString randomName];
    self.url = [NSURL URLWithString:kBPVImageURL];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

- (BPVImage *)image {
    return [BPVImage imageWithUrl:self.url];
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kBPVUserName];
    [aCoder encodeObject:self.surname forKey:kBPVUserSurname];
    [aCoder encodeObject:self.url forKey:kBPVUserURL];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:kBPVUserName];
        self.surname = [aDecoder decodeObjectForKey:kBPVUserSurname];
        self.url = [aDecoder decodeObjectForKey:kBPVUserURL];
    }
    
    return self;
}

@end
