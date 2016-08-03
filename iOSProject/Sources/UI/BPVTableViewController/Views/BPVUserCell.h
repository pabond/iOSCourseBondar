//
//  BPVUserCell.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPVUser;

@interface BPVUserCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel      *userNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *userImageView;

@property (nonatomic, strong) BPVUser *user;

- (void)fillWithModel:(BPVUser *)user;

@end
