//
//  NSBundle+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/25/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (BPVExtensions)

+ (id)objectWithClass:(Class)cls;

+ (NSArray *)loadNibWithClass:(Class)cls;
+ (NSArray *)loadNibWithClass:(Class)cls owner:(id)owner;
+ (NSArray *)loadNibWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
