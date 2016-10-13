//
//  BPVModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

typedef NS_ENUM(NSUInteger, BPVModelState) {
    BPVModelDidUnload,
    BPVModelWillLoad,
    BPVModelDidLoad,
    BPVModelFailLoading,
    BPVCount
};

@protocol BPVModelObserver <NSObject>

@optional
- (void)modelDidLoad:(id)model;
- (void)modelFailLoading:(id)model;

- (void)modelWillLoad:(id)model;
- (void)modelDidUnload:(id)model;

@end

@interface BPVModel : BPVObservableObject

//these methods sould be implemented in subclasses
- (void)save;
- (void)load;
- (void)performLoading;

//this method cen be implemented in subclasses if needed
- (BOOL)shouldNotifyOfState:(NSUInteger)state;

@end
