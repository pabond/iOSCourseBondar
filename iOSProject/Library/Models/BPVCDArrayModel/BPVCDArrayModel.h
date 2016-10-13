//
//  BPVCDArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "BPVArrayModel.h"

@class BPVCDArrayModel;
@class BPVUser;

typedef NS_ENUM(NSUInteger, BPVCDArrayModelState) {
    BPVCDArrayModelUpdateObject = BPVArrayModelCount,
};

@protocol BPVCDArrayModelProtocol <NSObject>

- (void)arrayModel:(BPVCDArrayModel *)arrayModel didUpdateObject:(id <BPVObservableObjectProtocol>)object;

@end

@interface BPVCDArrayModel : BPVArrayModel <NSFetchedResultsControllerDelegate>
@property (nonatomic, readonly) NSSet               *modelsSet;
@property (nonatomic, readonly) NSPredicate         *predicate;
@property (nonatomic, readonly) NSSortDescriptor    *sortDesriptor;

+ (instancetype)CDArrayModelWithObject:(id <BPVObservableObjectProtocol>)object;

@end
