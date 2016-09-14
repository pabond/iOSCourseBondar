//
//  BPVAddModel+BPVArrayModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAddModel+BPVArrayModel.h"

@implementation BPVAddModel (UITableView)

- (void)applyToModel:(BPVArrayModel *)model withObject:(id)object {
    [model addModel:object];
}

@end
