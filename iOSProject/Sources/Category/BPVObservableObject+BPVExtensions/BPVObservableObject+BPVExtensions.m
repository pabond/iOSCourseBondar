//
//  BPVObservableObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject+BPVExtensions.h"

@implementation BPVObservableObject (BPVExtensions)

- (void)performBlockWithoutNotification:(BPVBlock)block {
    if (block) {
        block();
    }
}

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object {

}

@end
