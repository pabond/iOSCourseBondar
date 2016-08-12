//
//  BPVBackgroundView.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BPVSquarePositionLeftTop,
    BPVSquarePositionLeftButtom,
    BPVSquarePositionRightButtom,
    BPVSquarePositionRightTop
} BPVSquarePositionType;

typedef void(^BPVHandler)(void);

@interface BPVBackgroundView : UIView
@property (nonatomic, strong) IBOutlet UIView           *squareView;
@property (nonatomic, strong) IBOutlet UIButton         *autoAnimation;
@property (nonatomic, strong) IBOutlet UIButton         *randomSquarePosition;

@property (nonatomic, assign) BPVSquarePositionType     squarePosition;

@property (nonatomic, assign, getter=isAnimating) BOOL   animating;

- (void)startAutoAnimation;
- (void)rundomSquarePostion;

@end
