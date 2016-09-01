//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BPVModelImageState) {
    BPVModelImageDidUnloaded,
    BPVModelImageWillLoad,
    BPVModelImageDidLoad,
    BPVModelImageFailLoading
};

@protocol BPVModelObserver <NSObject>

@optional
- (void)modelImageDidUnload:(id)user;
- (void)modelImageWillLoad:(id)user;

- (void)modelImageDidLoad:(id)user;
- (void)modelImageFailLoading:(id)user;

@end

@interface BPVUser : BPVObservableObject <NSCoding>
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, copy)     NSString *surname;
@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) UIImage  *image;

@end
