//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface BPVUser : NSObject
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, copy)     NSString *surname;
@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) UIImage  *image;

@end
