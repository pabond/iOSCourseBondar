//
//  BPVArrayModelsCollection.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModelsCollection.h"

#import "BPVArrayChange.h"

#define kBPVCollection @"users"
#define kBPVDataFilePath @"/Users/bondarpavel/Documents/MyGitProjects/iOSCourse/iOSProject/Sources/DataSaving/data.plist"

@interface BPVArrayModelsCollection ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

@end

@implementation BPVArrayModelsCollection

@dynamic models;
@dynamic count;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableModels = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)models {
    return [self.mutableModels copy];
}

- (NSUInteger)count {
    return [self.mutableModels count];
}

#pragma mark -
#pragma mark Public implementations

- (void)addModel:(id)model {
    if (model) {
        [self.mutableModels addObject:model];
        [self notifyOfState:BPVChangingTypeAdd withObject:[BPVArrayChange addingObjectWithIndex:[self indexOfModel:model]]];
    }
}

- (void)removeModel:(id)user {
    if (user) {
        [self.mutableModels removeObject:user];
    }
}

- (void)addModels:(NSArray *)models {
    if (models) {
        for (id model in models) {
            [self addModel:model];
        }
    }
}

- (id)modelAtIndex:(NSUInteger)index {
    NSMutableArray *models = self.mutableModels;
    
    if (index < models.count) {
        return [models objectAtIndex:index];
    }
    
    return nil;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    id model = [self modelAtIndex:fromIndex];
    BOOL notify = NO;
    [self removeModelAtIndex:fromIndex notify:notify];
    [self insertModel:model atIndex:toIndex notify:notify];
    [self notifyOfState:BPVChangingTypeMove
             withObject:[BPVArrayChange movingObjectwithIndex:toIndex
                                                                  fromIndex:fromIndex]];
}

- (void)insertModel:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify {
    if (user) {
        [self.mutableModels insertObject:user atIndex:index];
        if (notify) {
            [self notifyOfState:BPVChangingTypeAdd withObject:[BPVArrayChange addingObjectWithIndex:index]];
        }
    }
}

- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify {
    [self.mutableModels removeObjectAtIndex:index];
    if (notify) {
        [self notifyOfState:BPVChangingTypeRemove withObject:[BPVArrayChange removingObjectWithIndex:index]];
    }
}

- (NSUInteger)indexOfModel:(id)model {
    return [self.mutableModels indexOfObject:model];
}

#pragma mark -
#pragma mark Redefinition of parent methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVChangingTypeAdd:
        case BPVChangingTypeMove:
        case BPVChangingTypeRemove:
            return @selector(collection:didUpdateWithArrayChangeModel:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark saving and restoring of state

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.models];
    
    if ([data writeToFile:kBPVDataFilePath atomically:NO]) {
        NSLog(@"Saving operation succeeds");
    } else {
        NSLog(@"Data not saved");
    }
}

- (void)load {
    NSData *data = [NSData dataWithContentsOfFile:kBPVDataFilePath];
    if (data) {
        [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)length
{
    return [self.mutableModels countByEnumeratingWithState:state objects:buffer count:length];
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self forKey:kBPVCollection];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.mutableModels = [NSMutableArray arrayWithArray:[aDecoder decodeObjectForKey:kBPVCollection]];
    }
    
    return self;
}

@end
