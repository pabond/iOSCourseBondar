//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVModel.h"

@class BPVImage;
@class BPVUsers;

typedef NS_ENUM(NSUInteger, BPVUserLoadState) {
    BPVModelDidLoadID = BPVCount,
    BPVModelDidLoadDetailedInfo,
    BPVModelDidLoadFriends,
    BPVModelWillLoadDetailedInfo,
    BPVModelWillLoadFriends,
    BPVModelFailLoadingDetailedInfo,
    BPVModelFailLoadingFriends
};

@protocol BPVUserObserver <BPVModelObserver>

@optional
- (void)modelDidLoadID:(id)model;
- (void)modelDidLoadDetailedInfo:(id)model;
- (void)modelDidLoadFriends:(id)model;
- (void)modelWillLoadDetailedInfo:(id)model;
- (void)modelWillLoadFriends:(id)model;
- (void)modelFailLoadingFriends:(id)model;
- (void)modelFailLoadingDetailedInfo:(id)model;

@end

@interface BPVUser : BPVModel <NSCoding>
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *surname;
@property (nonatomic, readonly) NSString    *fullName;

@property (nonatomic, readonly) BPVImage    *image;
@property (nonatomic, strong)   NSURL       *imageURL;

@property (nonatomic, copy)     NSString    *birthday;
@property (nonatomic, copy)     NSString    *email;

@property (nonatomic, copy)     NSString    *ID;

@property (nonatomic, readonly) BPVUsers    *friends;

@end
