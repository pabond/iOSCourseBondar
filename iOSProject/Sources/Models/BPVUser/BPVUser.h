//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObject.h"
#import <CoreData/CoreData.h>
#import "BPVObservableObjectProtocol.h"

#import "BPVModel.h"

#define BPVUnspec _Null_unspecified

@class BPVImage;
@class BPVUsers;
@class BPVArrayModel;

typedef NS_ENUM(NSUInteger, BPVUserLoadState) {
    BPVModelDidLoadID = BPVCount,
    BPVModelDidLoadDetailedInfo,
    BPVModelWillLoadDetailedInfo,
    BPVModelFailLoadingDetailedInfo
};

@protocol BPVUserObserver <BPVModelObserver>

@optional
- (void)modelDidLoadID:(id BPVUnspec)model;
- (void)modelDidLoadDetailedInfo:(id BPVUnspec)model;
- (void)modelWillLoadDetailedInfo:(id BPVUnspec)model;
- (void)modelFailLoadingDetailedInfo:(id BPVUnspec)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BPVUser : BPVObject <BPVObservableObject>
@property (nonatomic, readonly) BPVArrayModel   *arrayModel;
@property (nonatomic, readonly) NSString        *fullName;
@property (nonatomic, readonly) BPVImage        *image;

+ (instancetype)objectWithID:(nullable NSString *)userID;

@end

NS_ASSUME_NONNULL_END

#undef BPVUnspec

#import "BPVUser+CoreDataProperties.h"
