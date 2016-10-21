//
//  BPVObject.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BPVObject : NSManagedObject

+ (instancetype)objectWithPredicate:(NSPredicate *)predicat;

@end
