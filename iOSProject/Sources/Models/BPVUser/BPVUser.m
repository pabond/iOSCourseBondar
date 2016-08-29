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

#define kBPVUserName @"userName"
#define kBPVUserSurname @"userSurname"

@implementation BPVUser

@dynamic fullName;
@dynamic image;

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

- (UIImage *)image {
    static dispatch_once_t onceToken;
    static NSString *path = nil;
    static UIImage *image = nil;
    
    BPVWeakify(self)
    BPVPerformAsyncBlockOnBackgroundQueue(^{
        BPVStrongifyAndReturnNilIfNil(self)
        dispatch_once(&onceToken, ^{
            path = [[NSBundle mainBundle] pathForResource:@"BPVUserLogo" ofType:@"png"];
            image = [UIImage imageWithContentsOfFile:path];
        });
    });
    
    return image;
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
