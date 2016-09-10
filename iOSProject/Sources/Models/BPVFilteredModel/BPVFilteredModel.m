//
//  BPVFilteredModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFilteredModel.h"

#import "BPVUsers.h"
#import "BPVUser.h"
#import "BPVArrayChange.h"
#import "BPVAddModel.h"

#import "NSArray+BPVExtensions.h"

@interface BPVFilteredModel ()
@property (nonatomic, readonly)     BPVUsers        *rootModel;
@property (nonatomic, copy)         NSString        *filterString;

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
    [self addModels:array];
    
    return self;
}


#pragma mark -
#pragma mark Accessors

- (void)setModel:(BPVUsers *)model {
    
}

#pragma mark -
#pragma mark Public implementations

- (void)filterArrayWithSting:(NSString *)text {
    if (!text) {
        return;
    }
    
    self.filterString = text;
    
    [self removeAllObjects];
    NSArray *array = [[[self.rootModel copy] filteredUsingBlock:^BOOL(BPVUser *user) {
        return [user.fullName containsString:text];
    }] mutableCopy];
    
    [self addModels:array];
    
    [self notifyOfState:BPVModelDidFilter];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelDidFilter:
            return @selector(modelDidFilter:);
            
        default:
            return [super selectorForState:state];
   }
}

#pragma mark -
#pragma mark Private implementations

- (BOOL)shouldApplyWithObject:(BPVUser *)object {
    return [object.fullName containsString:self.filterString];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoad:(BPVArrayModel *)model {
    [self notifyOfState:model.state];
}

- (void)modelFailLoading:(BPVArrayModel *)model {
    [self notifyOfState:model.state];
}

- (void)modelWillLoad:(BPVArrayModel *)model {
    [self notifyOfState:model.state];
}

#pragma mark -
#pragma mark BPVArrayModelObserver

- (void)model:(id)model didChangeWithModel:(BPVArrayChange *)changeModel {
    if (changeModel) {
        id object = changeModel.object;
        if ([changeModel isMemberOfClass:[BPVAddModel class]] && ![self shouldApplyWithObject:object]) {
            return;
        }
        
        [changeModel applyToModel:self withObject:object];
    }
}

@end
