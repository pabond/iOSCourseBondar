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

+ (instancetype)removingChangeModelWithIndex:(NSUInteger)index;
+ (instancetype)addingChangeModelWithIndex:(NSUInteger)index;
+ (instancetype)movingChangeModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

@end
