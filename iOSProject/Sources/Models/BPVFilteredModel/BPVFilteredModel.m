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
#import "BPVArrayChange+BPVFilteredModel.h"
#import "BPVAddModel.h"

#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

@interface BPVFilteredModel ()
@property (nonatomic, strong)   BPVUsers    *rootModel;
@property (nonatomic, copy)     NSString    *filterString;

- (void)addModelsWiththoutNotification:(NSArray *)array;
- (BOOL)shouldApplyWithObject:(BPVUser *)object;

@end

@implementation BPVFilteredModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)filteredModelWithBaceObject:(id)object {
    return [[self alloc] initWithBaceObject:object];
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithBaceObject:(id)obect {
    self = [super init];
    self.rootModel = obect;
    
    return self;
}

#pragma mark -
#pragma mark Public implementations

- (void)filterArrayWithString:(NSString *)text {
    if ([text  isEqual: @""]) {
        text = @" ";
    }

    self.filterString = text;
    
    [self removeAllObjects];
    NSArray *array = [[self.rootModel.models filteredUsingBlock:^BOOL(BPVUser *user) {
        if (!text) {
            return YES;
        }
        
        return [user.fullName localizedCaseInsensitiveContainsString:text];
    }] mutableCopy];
    
    BPVWeakify(self)
    [self performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [self addModels:array];
    }];
    
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

- (void)addModelsWiththoutNotification:(NSArray *)array {
    BPVWeakify(self)
    [self performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [self addModels:array];
    }];
}

- (BOOL)shouldApplyWithObject:(BPVUser *)object {
    NSString *string = self.filterString;
    if (!string) {
        return YES;
    }
    
    return [object.fullName containsString:string];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoad:(BPVArrayModel *)model {
    [self addModelsWiththoutNotification:model.models];
    
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
