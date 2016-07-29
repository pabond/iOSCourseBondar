//
//  BPVBackgroundView.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVSquareView.h"

typedef enum {
    BPVSquarePositionLeftTop,
    BPVSquarePositionLeftButtom,
    BPVSquarePositionRightButtom,
    BPVSquarePositionRightTop
} BPVSquarePositionType;

typedef void(^BPVHandler)(void);

@interface BPVBackgroundView : UIView
@property (nonatomic, strong) IBOutlet BPVSquareView    *squareView;
@property (nonatomic, strong) IBOutlet UIButton         *autoAnimation;
@property (nonatomic, strong) IBOutlet UIButton         *randomSquarePosition;

@property (nonatomic, assign) BPVSquarePositionType     squarePosition;

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated;
- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler;

- (BPVSquarePositionType)nextSquarePosition;
- (BPVSquarePositionType)rundomSquarePostion;

@end
