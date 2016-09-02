//
//  BPVUserCell.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVUser.h"

@class BPVLoadingView;

@interface BPVUserCell : UITableViewCell <BPVModelObserver>
@property (nonatomic, strong) IBOutlet UILabel          *userNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView      *userImageView;
@property (nonatomic, strong) IBOutlet BPVLoadingView   *loadingView;
@property (nonatomic, assign) BOOL                      loading;

@property (nonatomic, strong) BPVUser *user;

- (void)fillWithModel:(BPVUser *)user;

@end
