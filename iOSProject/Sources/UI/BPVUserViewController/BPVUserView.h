//
//  BPVUserView.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVView.h"

#import <UIKit/UIKit.h>

@class BPVImageView;
@class BPVUser;

@interface BPVUserView : BPVView
@property (nonatomic, strong) IBOutlet  BPVImageView    *imageView;
@property (nonatomic, strong) IBOutlet  UIButton        *friendsButton;

@property (nonatomic, strong) IBOutlet  UILabel         *name;
@property (nonatomic, strong) IBOutlet  UILabel         *nameContainer;

@property (nonatomic, strong) IBOutlet  UILabel         *surname;
@property (nonatomic, strong) IBOutlet  UILabel         *surnameContainer;

@property (nonatomic, strong) IBOutlet  UILabel         *birthday;
@property (nonatomic, strong) IBOutlet  UILabel         *birthdayContainer;

@property (nonatomic, strong) IBOutlet  UILabel         *email;
@property (nonatomic, strong) IBOutlet  UILabel         *emailContainer;

@property (nonatomic, strong) BPVUser   *user;

@end
