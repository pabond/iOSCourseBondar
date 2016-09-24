//
//  BPVContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVContext : BPVObservableObject
@property (nonatomic, assign, getter=isCanceled) BOOL canceled;

// you should never call this methods directly from outside subclasses
// this method should be rewritten in subclasses
- (void)execute;

- (void)cancel;

@end
