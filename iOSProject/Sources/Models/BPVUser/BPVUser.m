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
BPVStringConstantWithValue(kBPVUserImageName, BPVUserLogo);
BPVStringConstantWithValue(kBPVUserImageFormat, png);

@interface BPVUser ()
@property (nonatomic, strong) BPVImage                  *userImage;

@end

@implementation BPVUser

@dynamic image;

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

- (UIImage *)image {
    return self.userImage.image;
}

- (void)setUserImage:(BPVImage *)userImage {
    if (_userImage != userImage) {
        [_userImage removeObserver:self];
        
        _userImage = userImage;
        [_userImage addObserver:self];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    @synchronized (self) {
        self.userImage = [BPVImage imageFromUrl:[NSURL URLWithString:[self imagePath]]];
    }
}

- (void)cancelImageLoading {
    self.userImage = nil;
}

#pragma mark -
#pragma mark Private implementations

- (NSString *)imagePath {
    return [[NSBundle mainBundle] pathForResource:kBPVUserImageName ofType:kBPVUserImageFormat];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoad:(BPVImage *)model {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.state = BPVModelDidLoad;
    });
}

- (void)modelFailLoading:(id)model {
    [self performLoading];
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
