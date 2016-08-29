//
//  BPVLoadingViewModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPVHandler)(void);

@interface BPVLoadingViewModel : UIView

@property (nonatomic, assign)   BOOL    visible;

+ (id)loadingViewInSuperView:(UIView *)superView;

- (void)setVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated complitionHandler:(BPVHandler)complition;

@end
