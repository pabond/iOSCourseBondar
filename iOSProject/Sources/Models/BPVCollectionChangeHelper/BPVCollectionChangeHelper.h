//
//  BPVCollectionChangeHelper.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@protocol BPVCollectionObserver <NSObject>

typedef enum {
    BPVChangingTypeAdd,
    BPVChangingTypeRemove,
    BPVChangingTypeMove
} BPVChangingType;

- (void)collection:(id)collection didUpdateWithUserData:(id)data;

@end

@interface BPVCollectionChangeHelper : BPVObservableObject

+ (instancetype)removingObjectWithIndex:(NSUInteger)index;
+ (instancetype)addingObjectWithIndex:(NSUInteger)index;

- (id)objectWithChangingType:(BPVChangingType)type index:(NSUInteger)index;

@end
