//
//  BPVImageModelDispatcher.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPVImage;

@interface BPVImageModelDispatcher : NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate>

+ (instancetype)shareDespatcher;

- (void)loadImage:(BPVImage *)image;

@end
