//
//  BPVModelsCollection.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVModelsCollection : BPVObservableObject
@property (nonatomic, readonly) NSArray     *modelsArray;
@property (nonatomic, readonly) NSUInteger  count;

- (void)addModel:(id)user;
- (void)removeModel:(id)user;

- (id)modelAtIndex:(NSUInteger)index;

- (void)insertModel:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify;
- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify;

// you should never call this method  directly from outside
// use instead two previous methos with notify value "YES"
- (void)moveModelFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

@end
