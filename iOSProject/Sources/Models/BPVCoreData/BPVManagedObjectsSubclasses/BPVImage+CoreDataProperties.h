//
//  BPVImage+CoreDataProperties.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/6/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BPVImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPVImage (CoreDataProperties)
@property (nonatomic, copy)     NSString *path;
@property (nonatomic, strong)   BPVUser *user;

@end

NS_ASSUME_NONNULL_END
