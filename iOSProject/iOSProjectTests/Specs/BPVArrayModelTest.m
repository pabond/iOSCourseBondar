//
//  BPVArrayModelTest.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Kiwi.h"

#import "BPVArrayModel.h"

#import "NSArray+BPVExtensions.h"

#import "NSMutableArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVConstant(NSUInteger, kBPVObjectsCount, 20);

SPEC_BEGIN(BPVArrayModelTest);

describe(@"BPVArrayModel move", ^{
    __block NSMutableArray *objects = nil;
    
    context(@"move users test", ^{
        beforeAll(^{
            objects = [[NSArray arrayWithObjectsFactoryWithCount:20 block:^id{
                return [NSObject new];
            }] mutableCopy];
        });
        
        it([NSString stringWithFormat:@"contain %lu strings", (unsigned long)kBPVObjectsCount], ^{
            [[[objects should] have:kBPVObjectsCount] items];
        });
        
        __block id object = nil;
        
        it(@"object at index should be equal to object at the index", ^{
            object = [objects objectAtIndex:5];
            
            [[[objects objectAtIndex:5] should] equal:object];
        });
        
        it(@"object after move should be equal to object at destinations index", ^{
            [objects moveObjectFromIndex:5 toIndex:0];
            [[[objects firstObject] should] equal:object];
        });
        
        it(@"object after move should be equal to object at destinations index", ^{
            [objects moveObjectFromIndex:0 toIndex:5];
            [[[objects objectAtIndex:5] should] beIdenticalTo:object];
        });
    });
});

SPEC_END
