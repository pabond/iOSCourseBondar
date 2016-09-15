//
//  NSString+BPVRandomName.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSString+BPVRandomName.h"

#import "NSString+BPVExtensions.h"

static const NSInteger kBPVRandomNameLength = 10;

@implementation NSString (BPVRandomName)

+ (instancetype)randomName {
    NSString *alphabet = [self lowercaseLetterAlphabet];
    
    return [[self randomStringWithLength:kBPVRandomNameLength alphabet:alphabet] capitalizedString];
}

@end
