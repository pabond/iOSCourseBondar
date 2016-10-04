//
//  BPVFilteredModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

typedef NS_ENUM(NSUInteger, BPVFilteredModelState) {
    BPVModelDidFilter = BPVArrayModelCount
};

@protocol BPVFilteredModelObserver <NSObject, BPVModelObserver>

@optional
- (void)modelDidFilter:(id)model;

@end

@interface BPVFilteredModel : BPVArrayModel <BPVModelObserver, BPVArrayModelObserver>
@property (nonatomic, strong)   BPVArrayModel   *arrayModel;

- (void)filterArrayWithString:(NSString *)text;

@end
