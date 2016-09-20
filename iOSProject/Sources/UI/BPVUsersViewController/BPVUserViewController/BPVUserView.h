//
//  BPVUserView.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPVImageView;
@class BPVUser;

@interface BPVUserView : UIView
@property (nonatomic, strong) IBOutlet  BPVImageView    *imageView;
@property (nonatomic, strong) IBOutlet  UILabel         *nameContainer;
@property (nonatomic, strong) IBOutlet  UILabel         *name;
@property (nonatomic, strong) IBOutlet  UILabel         *surnameContainer;
@property (nonatomic, strong) IBOutlet  UILabel         *surname;

@property (nonatomic, strong) BPVUser   *user;

@end
