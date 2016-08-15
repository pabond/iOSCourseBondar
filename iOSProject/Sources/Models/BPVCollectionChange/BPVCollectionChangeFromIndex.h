//
//  BPVCollectionChangeFromIndex.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChange.h"

@interface BPVCollectionChangeFromIndex : BPVCollectionChange
@property (nonatomic, assign)   NSUInteger      fromIndex;
@property (nonatomic, readonly) NSIndexPath     *fromIndexPath;

+ (instancetype)movingObjectwithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

@end
