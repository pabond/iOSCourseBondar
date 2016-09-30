//
//  BPVModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModel.h"

#import "BPVGCD.h"

#import "NSFileManager+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVModelsFolder, BPVModels);

@implementation BPVModel

@dynamic isCached;
@dynamic filePath;
@dynamic applicationModelsPath;

#pragma mark -
#pragma mark Accessors

- (NSString *)applicationModelsPath {
    return  [NSFileManager applicationDataPathWithFolderName:kBPVModelsFolder];
}

- (NSString *)filePath {
    return nil;
}

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.filePath];
}

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

- (id)cachedModel {
    return [NSKeyedUnarchiver objectFromFileWithPath:self.filePath];
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

@end
