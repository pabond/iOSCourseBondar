//
//  BPVCollectionChange.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVCollectionChange : BPVObservableObject
@property (nonatomic, assign) NSUInteger index;

+ (instancetype)removingObjectWithIndex:(NSUInteger)index;
+ (instancetype)addingObjectWithIndex:(NSUInteger)index;

- (instancetype)initWithIndex:(NSUInteger)index;

@end
