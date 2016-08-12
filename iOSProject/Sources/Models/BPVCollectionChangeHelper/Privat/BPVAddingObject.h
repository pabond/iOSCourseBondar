//
//  BPVAddingObject.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChangeHelper.h"

@interface BPVAddingObject : BPVCollectionChangeHelper
@property (nonatomic, assign)   NSUInteger  index;

- (instancetype)initAddingObjectWithIndex:(NSUInteger)index;

@end
