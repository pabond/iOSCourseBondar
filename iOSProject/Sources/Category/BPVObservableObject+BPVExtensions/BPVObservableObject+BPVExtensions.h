//
//  BPVObservableObject+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVObservableObject (BPVExtensions)

- (void)performBlockWithoutNotification:(BPVBlock)block;

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object;

@end
