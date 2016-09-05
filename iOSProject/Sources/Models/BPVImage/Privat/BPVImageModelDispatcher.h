//
//  BPVImageModelDispatcher.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/17/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPVQueue;
@class BPVImage;

@interface BPVImageModelDispatcher : NSObject
@property (nonatomic, readonly) BPVQueue *queue;

+ (instancetype)shareDespatcher;

- (void)loadImage:(BPVImage *)image;

@end
