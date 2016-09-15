//
//  BPVUserCell.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVUser.h"

@class BPVView;
@class BPVImageView;

@interface BPVUserCell : UITableViewCell <BPVModelObserver>
@property (nonatomic, strong) IBOutlet UILabel          *userNameLabel;
@property (nonatomic, strong) IBOutlet BPVImageView     *userImageView;
@property (nonatomic, strong) IBOutlet BPVView          *contentLoadingView;

@property (nonatomic, strong) BPVUser *user;

- (void)fillWithModel:(BPVUser *)user;

@end
