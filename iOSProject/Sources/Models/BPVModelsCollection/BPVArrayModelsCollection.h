//
//  BPVArrayModelsCollection.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

typedef enum {
    BPVChangingTypeAdd,
    BPVChangingTypeRemove,
    BPVChangingTypeMove
} BPVChangingType;

@protocol BPVCollectionObserver <NSObject, NSCoding>

- (void)collection:(id)collection didUpdateWithArrayChangeModel:(id)changeModel;

@end

@interface BPVArrayModelsCollection : BPVObservableObject
@property (nonatomic, readonly) NSArray     *modelsArray;
@property (nonatomic, readonly) NSUInteger  count;

- (void)addModel:(id)user;
- (void)removeModel:(id)user;

- (void)addModels:(NSArray *)models;

- (id)modelAtIndex:(NSUInteger)index;

- (void)insertModel:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify;
- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify;

// you should never call this method  directly from outside
// use instead two previous methos with notify value "YES"
- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;
- (id)load;

@end
