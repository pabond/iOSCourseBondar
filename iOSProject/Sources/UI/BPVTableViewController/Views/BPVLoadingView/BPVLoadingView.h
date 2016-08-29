//
//  BPVLoadingView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoadingViewModel.h"

@interface BPVLoadingView : BPVLoadingViewModel
@property (nonatomic, strong) IBOutlet UILabel                  *label;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView  *spinner;

@end
