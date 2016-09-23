//
//  BPVContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVContext : BPVObservableObject

- (void)execute;
- (void)cancel;

@end
