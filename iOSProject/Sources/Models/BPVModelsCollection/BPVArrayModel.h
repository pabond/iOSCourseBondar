//
//  BPVArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

typedef NS_ENUM(NSUInteger, BPVCollectionState) {
    BPVModelsArrayNotLoad,
    BPVModelsArrayWillLoad,
    BPVModelsArrayDidLoad,
    BPVModelsArrayFailLoading,
    BPVModelsArrayDidChange
};

@protocol BPVArrayModelObserver <NSObject>

- (void)collection:(id)collection didChangeWithModel:(id)changeModel;
- (void)collectionDidLoad:(id)collection;
- (void)collectionFailLoading:(id)collection;

@optional
- (void)collectionWillLoad:(id)collection;
- (void)collectionNotLoad:(id)collection;

@end

@interface BPVArrayModel : BPVObservableObject <NSFastEnumeration>
@property (nonatomic, readonly) NSArray     *models;
@property (nonatomic, readonly) NSUInteger  count;

- (void)addModel:(id)model;
- (void)removeModel:(id)model;

- (void)addModels:(NSArray *)models;

- (id)modelAtIndex:(NSUInteger)index;

- (void)insertModel:(id)model atIndex:(NSUInteger)index;
- (void)removeModelAtIndex:(NSUInteger)index;

// you should never call this method  directly from outside
// use instead two previous methos with notify value "YES"
- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (void)save;
- (void)load;

@end
