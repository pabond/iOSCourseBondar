//
//  BPVCollectionChangeHelper.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVCollectionChangeHelper : BPVObservableObject

+ (instancetype)removingObjectWithIndex:(NSUInteger)index;
+ (instancetype)addingObjectWithIndex:(NSUInteger)index;

@end
