//
//  BPVArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModel.h"

typedef NS_ENUM(NSUInteger, BPVModelChangeState) {
    BPVModelDidChange = BPVCount,
    BPVArrayModelCount
};

@protocol BPVArrayModelObserver <NSObject, BPVModelObserver>

@optional
- (void)model:(id)model didChangeWithModel:(id)changeModel;

@end

@interface BPVArrayModel : BPVModel <NSFastEnumeration, NSCopying>
@property (nonatomic, readonly) NSArray     *models;
@property (nonatomic, readonly) NSUInteger  count;

- (void)addModel:(id)model;
- (void)removeModel:(id)model;

- (void)addModels:(NSArray *)models;
- (void)removeAllObjects;

- (id)modelAtIndex:(NSUInteger)index;

- (void)insertModel:(id)model atIndex:(NSUInteger)index;
- (void)removeModelAtIndex:(NSUInteger)index;

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

@end
