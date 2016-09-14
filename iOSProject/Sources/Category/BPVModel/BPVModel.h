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

- (void)save;
- (void)load;

//this method sould be implemented in subclasses
- (void)performLoading;

//this method cen be implemented in subclasses if needed
- (BOOL)shouldNotifyOfState:(NSUInteger)state;

- (void)startObservationForSelectorName:(NSString *)name block:(BPVBlock)block;
- (void)startObservationForSelectorNames:(NSArray *)names block:(BPVBlock)block;

- (void)endObservationWithSelectorNames:(NSArray *)names;
- (void)endObservationWithSelectorName:(NSString *)name;

@end
