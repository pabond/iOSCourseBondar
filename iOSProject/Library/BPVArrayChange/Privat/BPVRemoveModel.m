//
//  BPVRemoveModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemoveModel.h"

#import "BPVFilteredModel.h"

@implementation BPVRemoveModel

- (void)applyToModel:(BPVFilteredModel *)model withObject:(id)object {
    [model removeModel:object];
}

@end
