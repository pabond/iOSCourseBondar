//
//  BPVModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModel.h"

#import "BPVGCD.h"

#import "BPVMacro.h"

@interface BPVModel ()
@property (nonatomic, strong)   id  observer;

@end

@implementation BPVModel

#pragma mark -
#pragma mark Public imolementations

- (void)performLoading {
    
}

- (BOOL)shouldNotifyOfState:(NSUInteger)state {
    return BPVModelDidLoad == state || BPVModelWillLoad == state;
}

#pragma mark -
#pragma mark saving and restoring of state

- (void)save {
    
}

- (void)load {
    NSUInteger state = self.state;
    @synchronized (self) {
        if ([self shouldNotifyOfState:state]) {
            [self notifyOfState:state];
            
            return;
        }
        
        self.state = BPVModelWillLoad;
        
        BPVWeakify(self)
        BPVPerformAsyncBlockOnBackgroundQueue(^{
            BPVStrongifyAndReturnIfNil(self)
            [self performLoading];
        });
    }
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {            
        case BPVModelDidLoad:
            return @selector(modelDidLoad:);
            
        case BPVModelFailLoading:
            return @selector(modelFailLoading:);
            
        case BPVModelWillLoad:
            return @selector(modelWillLoad:);
            
        case BPVModelDidUnload:
            return @selector(modelDidUnload:);
            
        default:
            return [super selectorForState:state];
    }
}


#pragma mark -
#pragma mark Observation methods 

- (void)startObservationForSelectorName:(NSString *)name block:(BPVBlock)block {
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                      object:nil
                                                                       queue:nil
                                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                                      BPVPerformBlock(block);
                                                                  }];
}

- (void)startObservationForSelectorNames:(NSArray *)names block:(BPVBlock)block {
    for (NSString *name in names) {
        [self startObservationForSelectorName:name block:block];
    }
}

- (void)endObservationWithSelectorNames:(NSArray *)names {
    for (id name in names) {
        [self endObservationWithSelectorName:name];
    }
}

- (void)endObservationWithSelectorName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer name:name object:nil];
}

@end
