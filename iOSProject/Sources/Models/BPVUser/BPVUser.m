//
//  BPVUser.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUser.h"

#import "BPVGCD.h"

#import "NSString+BPVRandomName.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVUserName, userName);
BPVStringConstantWithValue(kBPVUserSurname, userSurname);
BPVStringConstantWithValue(kBPVUserImageName, BPVUserLogo);
BPVStringConstantWithValue(kBPVUserImageFormat, png);
BPVConstant(NSUInteger, kBPVSleepTime, 3);

@implementation BPVUser

@dynamic fullName;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = [NSString randomName];
        self.surname = [NSString randomName];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.name, self.surname];
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    @synchronized (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:kBPVUserImageName ofType:kBPVUserImageFormat];
        self.image = [UIImage imageWithContentsOfFile:path];
        
        sleep(kBPVSleepTime);
        self.state = BPVModelDidLoad;
    }
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kBPVUserName];
    [aCoder encodeObject:self.surname forKey:kBPVUserSurname];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:kBPVUserName];
        self.surname = [aDecoder decodeObjectForKey:kBPVUserSurname];
    }
    
    return self;
}

@end
