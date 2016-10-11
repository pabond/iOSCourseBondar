//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BPVObservableObjectProtocol.h"

#import "BPVModel.h"

@class BPVImage;
@class BPVUsers;

typedef NS_ENUM(NSUInteger, BPVUserLoadState) {
    BPVModelDidLoadID = BPVCount,
    BPVModelDidLoadDetailedInfo,
    BPVModelWillLoadDetailedInfo,
    BPVModelFailLoadingDetailedInfo
};

@protocol BPVUserObserver <BPVModelObserver>

@optional
- (void)modelDidLoadID:(id)model;
- (void)modelDidLoadDetailedInfo:(id)model;
- (void)modelWillLoadDetailedInfo:(id)model;
- (void)modelFailLoadingDetailedInfo:(id)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BPVUser : NSManagedObject <NSCoding, BPVObservableObjectProtocol>
@property (nonatomic, readonly) BPVObservableObject *observableObject;
//@property (nonatomic, readonly) BPVUsers            *friends;

@end

NS_ASSUME_NONNULL_END

#import "BPVUser+CoreDataProperties.h"
