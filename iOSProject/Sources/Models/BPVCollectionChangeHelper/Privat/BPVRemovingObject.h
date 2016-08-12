//
//  BPVRemovingObject.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChangeHelper.h"

@interface BPVRemovingObject : BPVCollectionChangeHelper
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initRemovingObjectWithIndex:(NSUInteger)index;

@end
