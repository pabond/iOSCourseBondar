//
//  UINib+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (BPVExtensions)

//Do not use these methods if you have more than ine nib with same class
+ (id)objectWithClass:(Class)cls;

+ (instancetype)nibWithClass:(Class)cls;
+ (instancetype)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
