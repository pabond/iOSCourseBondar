//
//  BPVMoveModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVMoveModel.h"

#import "BPVFilteredModel.h"

@implementation BPVMoveModel

- (void)applyToModel:(BPVFilteredModel *)model withObject:(id)object {
    [model moveModelFromIndex:self.fromIndex toIndex:self.index];
}

@end
