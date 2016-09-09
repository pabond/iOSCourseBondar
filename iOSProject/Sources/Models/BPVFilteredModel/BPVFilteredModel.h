//
//  BPVFilteredModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

typedef NS_ENUM(NSUInteger, BPVFilteredModelState) {
    BPVModelDidFilter
};

@protocol BPVFilteredModelObserver <NSObject>

@optional
- (void)modelDidFilter;

@end

@interface BPVFilteredModel : BPVArrayModel <BPVModelObserver>

+ (instancetype)filteredModelWithArray:(NSArray *)array;

- (void)filterArrayWithSting:(NSString *)text;

@end
