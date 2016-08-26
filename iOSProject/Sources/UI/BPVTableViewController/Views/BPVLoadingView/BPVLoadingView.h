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
@property (nonatomic, assign) BOOL  visible;
@property (nonatomic, assign) BOOL  stopLoading;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
