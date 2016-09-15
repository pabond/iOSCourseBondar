//
//  BPVImagesCache.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/9/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImagesCache.h"
#import "BPVImage.h"
#import "BPVMacro.h"

@interface BPVImagesCache ()
@property (nonatomic, strong) NSMapTable *cache;

@end

@implementation BPVImagesCache

#pragma mark -
#pragma mark Class methods

+ (instancetype)cache {
    BPVWeakify(self)
    BPVReturnOnce(BPVImagesCache, cache, ^{
        BPVStrongify(self)
        return [self new];
    });
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)init {
    self = [super init];
    self.cache = [NSMapTable weakToWeakObjectsMapTable];
    
    return self;
}

#pragma mark -
#pragma mark Public Implementaions

- (void)addImage:(BPVImage *)image withURL:(NSURL *)url {
    @synchronized (self) {
        if (![self containsImageWithURL:url]) {
            [self.cache setObject:image forKey:url];
        }
    }
}

- (void)removeImageWithURL:(NSURL *)url {
    @synchronized (self) {
        [self.cache removeObjectForKey:url];
    }
}

- (BOOL)containsImageWithURL:(NSURL *)url {
    BOOL result = NO;
    NSEnumerator *keys = [self.cache keyEnumerator];
        
    for (id key in keys) {
        if ([key isEqual:url]) {
            result = YES;
        }
    }
    
    return result;
}

- (BOOL)containsImage:(BPVImage *)image {
    BOOL result = NO;
    NSEnumerator *images = [self.cache objectEnumerator];
    
    for (id iterationImage in images) {
        if (image == iterationImage) {
            result = YES;
        }
    }
    
    return result;
}

- (BPVImage *)imageWithURL:(NSURL *)url {
    @synchronized (self) {
        return [self.cache objectForKey:url];
    }
}

@end
