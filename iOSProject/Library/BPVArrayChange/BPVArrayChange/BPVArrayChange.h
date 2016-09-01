//
//  BPVArrayCollectionChange.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import <Foundation/Foundation.h>

@interface BPVArrayChange : NSObject

+ (instancetype)removeModelWithIndex:(NSUInteger)index;
+ (instancetype)addModelWithIndex:(NSUInteger)index;
+ (instancetype)moveModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

@end
