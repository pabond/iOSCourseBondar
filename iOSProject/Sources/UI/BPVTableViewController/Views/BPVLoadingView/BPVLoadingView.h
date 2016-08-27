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
@property (nonatomic, strong) IBOutlet UILabel                  *label;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView  *spinner;

@property (nonatomic, assign) BOOL  visible;

+ (id)loadingViewInSuperView:(UIView *)superView;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated complitionHandler:(BPVHandler)complition;

@end
