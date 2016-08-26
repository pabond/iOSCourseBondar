//
//  BPVLoadingView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPVHandler)(void);

@interface BPVLoadingView : UIView
@property (strong, nonatomic) IBOutlet UILabel *loadingLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, assign) BOOL  visible;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated complitionHandler:(BPVHandler)complition;

- (void)loadingViewInSuperView:(UIView *)superView;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
