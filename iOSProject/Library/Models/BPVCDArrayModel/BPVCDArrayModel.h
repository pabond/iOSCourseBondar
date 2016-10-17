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
@property (nonatomic, assign)   NSPredicate         *predicate;
@property (nonatomic, readonly) NSSortDescriptor    *sortDesriptor;
@property (nonatomic, readonly) NSString            *keyPath;

+ (instancetype)CDArrayModelWithObject:(id <BPVObservableObjectProtocol>)object keyPath:(NSString *)keyPath;

- (instancetype)initWithObject:(id <BPVObservableObjectProtocol>)object keyPath:(NSString *)keyPath;

//Next methods not implemented
//- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
//- (void)insertModel:(id)model atIndex:(NSUInteger)index;

@end
