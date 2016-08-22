//
//  BPVArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

typedef NS_ENUM(NSUInteger, BPVCollectionState) {
    BPVCollectionDidChange,
    BPVCollectionDidLoad
};

@protocol BPVCollectionObserver <NSObject>

- (void)collection:(id)collection didUpdateWithArrayChangeModel:(id)changeModel;

@end

@protocol BPVCollectionLoading <NSObject>

- (void)collectionDidLoad:(id)collection;

@end

@interface BPVArrayModel : BPVObservableObject <NSFastEnumeration, NSCoding>
@property (nonatomic, readonly) NSArray     *models;
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
- (void)load;

@end
