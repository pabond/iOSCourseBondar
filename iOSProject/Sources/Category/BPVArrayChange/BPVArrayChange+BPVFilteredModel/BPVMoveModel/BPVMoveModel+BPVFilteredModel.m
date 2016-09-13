//
//  BPVMoveModel+BPVFilteredModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import "BPVMoveModel+BPVFilteredModel.h"

@implementation BPVMoveModel (BPVFilteredModel)

- (void)applyToModel:(BPVFilteredModel *)model withObject:(id)object {
    [model moveModelFromIndex:self.fromIndex toIndex:self.index];
}

@end
