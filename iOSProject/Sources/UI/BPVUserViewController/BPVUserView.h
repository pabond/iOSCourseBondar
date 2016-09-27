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

@property (nonatomic, strong) IBOutlet  UILabel         *nameLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *surnameLabel;

@property (nonatomic, strong) IBOutlet  UILabel         *birthdayLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *emailLabel;

@property (nonatomic, strong) BPVUser   *user;

@end
