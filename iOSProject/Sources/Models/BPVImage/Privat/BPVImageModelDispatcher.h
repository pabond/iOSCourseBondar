//
//  BPVImageModelDispatcher.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/17/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVImageModelDispatcher : NSObject
@property (nonatomic, readonly) NSOperationQueue *queue;

+ (instancetype)shareDespatcher;

@end
