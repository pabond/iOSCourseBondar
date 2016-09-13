//
//  BPVAddModel+BPVFilteredModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAddModel+BPVFilteredModel.h"

@implementation BPVAddModel (UITableView)

- (void)applyToModel:(BPVFilteredModel *)model withObject:(id)object {
    [model addModel:object];
}

@end
