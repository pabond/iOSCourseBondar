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
#import "BPVArrayChange+BPVArrayModel.h"
#import "BPVAddModel.h"
#import "BPVMoveModel.h"
#import "BPVRemoveModel.h"

#import "BPVGCD.h"

#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

@interface BPVFilteredModel ()
@property (nonatomic, strong)   BPVArrayModel   *rootModel;
@property (nonatomic, copy)     NSString        *filterString;

- (instancetype)initWithRootModel:(id)model;

- (void)addModelsWithoutNotification:(NSArray *)array;
- (BOOL)shouldApplyWithChangeModel:(BPVArrayChange *)changeModel;

@end

@implementation BPVFilteredModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)filteredModelWithRootModel:(id)model {
    return [[self alloc] initWithRootModel:model];
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithRootModel:(id)model {
    self = [super init];
    self.rootModel = model;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setRootModel:(BPVArrayModel *)rootModel {
    if (_rootModel != rootModel) {
        [_rootModel removeObserver:self];
        
        _rootModel = rootModel;
        [_rootModel addObserver:self];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)filterArrayWithString:(NSString *)text {
    BPVWeakify(self)
    BPVPerformAsyncBlockOnBackgroundQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        self.filterString = text;
        
        [self removeAllObjects];
        NSArray *array = [[self.rootModel.models filteredUsingBlock:^BOOL(BPVUser *user) {
            if (!text.length) {
                return YES;
            }
            
            return [user.fullName localizedCaseInsensitiveContainsString:text];
        }] mutableCopy];
        
        [self performBlockWithoutNotification:^{
            [self addModels:array];
        }];
        
        BPVPerformAsyncBlockOnMainQueue(^{
            BPVStrongifyAndReturnIfNil(self)
            [self notifyOfState:BPVModelDidFilter];
        });
    });
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

- (void)removeAllObjects {
    for (id object in self.models) {
        BPVWeakify(self)
        [self performBlockWithoutNotification:^{
            BPVStrongifyAndReturnIfNil(self)
            [self removeModel:object];
        }];
    }
}

- (void)addModelsWithoutNotification:(NSArray *)array {
    BPVWeakify(self)
    [self performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [self addModels:array];
    }];
}

- (BOOL)shouldApplyWithChangeModel:(BPVArrayChange *)changeModel {
    BPVUser *object = changeModel.object;
    BOOL result = NO;
    
    if ([changeModel isMemberOfClass:[BPVAddModel class]]) {
        result = [object.fullName containsString:self.filterString];
    } else if ([self containsModel:object]) {
        result = YES;
    }
    
    return result;
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoad:(BPVArrayModel *)model {
    [self addModelsWithoutNotification:model.models];
    
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
        if (![self shouldApplyWithChangeModel:changeModel]) {
            return;
        }
        
        [changeModel applyToModel:self withObject:changeModel.object];
    }
}

@end
