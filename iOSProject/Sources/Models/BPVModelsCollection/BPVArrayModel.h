//
//  BPVArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@protocol BPVCollectionObserver <NSObject, NSCoding>

- (void)collection:(id)collection didUpdateWithArrayChangeModel:(id)changeModel;

@end

@interface BPVArrayModel : BPVObservableObject <NSFastEnumeration>
@property (nonatomic, readonly) NSArray     *models;
@property (nonatomic, readonly) NSUInteger  count;

@property (nonatomic, readonly) NSInteger   laodedCount;

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
- (void)load;

@end
