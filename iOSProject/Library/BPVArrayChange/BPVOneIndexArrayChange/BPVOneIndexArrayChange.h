//
//  BPVOneIndexArrayChange.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayChange.h"

@interface BPVOneIndexArrayChange : BPVArrayChange

@property (nonatomic, assign)   NSUInteger  index;
@property (nonatomic, readonly) NSIndexPath *indexPath;

- (instancetype)initWithIndex:(NSUInteger)index object:(id)object;


@end
