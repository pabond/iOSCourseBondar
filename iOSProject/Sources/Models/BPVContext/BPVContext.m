//
//  BPVContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

@interface BPVContext ()
@property (nonatomic, assign, getter=isCanceled) BOOL canceled;

@end

@implementation BPVContext

- (void)execute {

}

- (void)cancel {
    self.canceled = YES;
}

@end
