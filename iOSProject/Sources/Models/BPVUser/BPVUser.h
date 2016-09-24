//
//  BPVUser.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVModel.h"

@class BPVImage;

@interface BPVUser : BPVModel <NSCoding>
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *surname;
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, readonly) BPVImage    *image;
@property (nonatomic, strong)   NSURL       *url;
@property (nonatomic, copy)     NSString    *birthday;
@property (nonatomic, copy)     NSString    *email;

@end
