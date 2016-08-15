//
//  BPVCollectionChange.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import "BPVObservableObject.h"

@interface BPVCollectionChange : BPVObservableObject
@property (nonatomic, assign)   NSUInteger  index;
@property (nonatomic, readonly) NSIndexPath *indexPath;

+ (instancetype)removingObjectWithIndex:(NSUInteger)index;
+ (instancetype)addingObjectWithIndex:(NSUInteger)index;

- (instancetype)initWithIndex:(NSUInteger)index;

//should be rewritten in child classes
- (void)performChangesToTableView:(UITableView *)tableView;

@end
