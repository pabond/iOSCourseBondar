//
//  BPVFilteredModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFilteredModel.h"

#import "NSArray+BPVExtensions.h"

#import "BPVUsers.h"
#import "BPVUser.h"

@interface BPVFilteredModel ()
@property (nonatomic, strong)   NSMutableArray  *model;
@property (nonatomic, copy)     NSString        *filterString;

- (instancetype)initWithArray:(NSArray *)array;

@end

@implementation BPVFilteredModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)filteredModelWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initializations and dealloacations

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        _model = [NSMutableArray arrayWithArray:array];
    }
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (void)setModel:(BPVUsers *)model {
    
}

#pragma mark -
#pragma mark Public implementations

- (void)filterArrayWithSting:(NSString *)text {
    self.model = [[self.model filteredUsingBlock:^BOOL(BPVUser *user) {
        return [user.fullName containsString:text];
    }] mutableCopy];
    
    [self notifyOfState:BPVModelDidFilter];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelDidFilter:
            return @selector(modelDidFilter);
            
        default:
            return [super selectorForState:state];
    }
}

@end
