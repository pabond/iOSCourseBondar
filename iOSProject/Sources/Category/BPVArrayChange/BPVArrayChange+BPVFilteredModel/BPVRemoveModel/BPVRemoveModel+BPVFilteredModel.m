//
//  BPVRemoveModel+BPVFilteredModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemoveModel+BPVFilteredModel.h"
#import "BPVMacro.h"

@implementation BPVRemoveModel (BPVFilteredModel)

- (void)applyToModel:(BPVFilteredModel *)model withObject:(id)object {
    [model removeModel:object];
}

@end
