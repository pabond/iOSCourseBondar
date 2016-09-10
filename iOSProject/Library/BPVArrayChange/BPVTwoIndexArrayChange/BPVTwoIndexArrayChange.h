//
//  BPVTwoIndexCollectionChange.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVOneIndexArrayChange.h"

@interface BPVTwoIndexArrayChange : BPVOneIndexArrayChange
@property (nonatomic, assign)   NSUInteger      fromIndex;
@property (nonatomic, readonly) NSIndexPath     *fromIndexPath;

- (instancetype)initWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex object:(id)object;

@end
