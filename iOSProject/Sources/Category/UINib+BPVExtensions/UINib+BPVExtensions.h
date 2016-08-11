//
//  UINib+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (BPVExtensions)

+ (id)objectUsingNibWithClass:(Class)cls;

+ (instancetype)nibWithClass:(Class)cls;
+ (instancetype)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
