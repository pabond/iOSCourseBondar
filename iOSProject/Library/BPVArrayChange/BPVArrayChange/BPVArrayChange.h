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
@property (nonatomic, strong)   id  object;

+ (instancetype)removeModelWithIndex:(NSUInteger)index object:(id)object;
+ (instancetype)addModelWithIndex:(NSUInteger)index object:(id)object;
+ (instancetype)moveModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex object:(id)object;

@end
