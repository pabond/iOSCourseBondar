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

BPVStringConstant(kBPVUserName);
BPVStringConstant(kBPVUserSurname);
BPVStringConstantWithValue(kBPVImageName, BPVUserLogo);
BPVStringConstantWithValue(kBPVImageType, png);

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
    NSUInteger state = self.state;
    
    if (state == BPVModelImageWillLoad || state == BPVModelImageDidLoad) {
        [self notifyOfState:state];
        
        return nil;
    }
    
    self.state = BPVModelImageWillLoad;
    
    static NSString *path = nil;
    static UIImage *image = nil;
    
    BPVPerformAsyncBlockOnBackgroundQueue(^{
        path = [[NSBundle mainBundle] pathForResource:kBPVImageName ofType:kBPVImageType];
        image = [UIImage imageWithContentsOfFile:path];
    });
    
    self.state = BPVModelImageDidLoad;
    
    return image;
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelImageDidUnloaded:
            return @selector(modelImageDidUnload:);
            
        case BPVModelImageWillLoad:
            return @selector(modelImageWillLoad:);
            
        case BPVModelImageDidLoad:
            return @selector(modelImageDidLoad:);
            
        case BPVModelImageFailLoading:
            return @selector(modelImageFailLoading:);
            
        default:
            return [super selectorForState:state];
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
