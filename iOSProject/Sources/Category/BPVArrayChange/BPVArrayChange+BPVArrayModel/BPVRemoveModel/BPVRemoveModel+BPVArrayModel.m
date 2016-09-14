//
//  BPVRemoveModel+BPVArrayModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemoveModel+BPVArrayModel.h"
#import "BPVMacro.h"

@implementation BPVRemoveModel (BPVArrayModel)

- (void)applyToModel:(BPVArrayModel *)model withObject:(id)object {
    [model removeModel:object];
}

@end
