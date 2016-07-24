//
//  BPVSquareView.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BPVSquarePositionLeftTop,
    BPVSquarePositionLeftButtom,
    BPVSquarePositionRightButtom,
    BPVSquarePositionRightTop
} BPVSquarePositionType;

typedef void (^BPVHandler)(void);

@interface BPVSquareView : UIView

@property (nonatomic, assign) BPVSquarePositionType squarePosition;
@property (nonatomic, strong) IBOutlet UIView   *square;

@property (nonatomic, strong) IBOutlet UIButton *autoAnimation;
@property (nonatomic, strong) IBOutlet UIButton *rundomSquarePosition;

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated;
- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler;
- (void)animateSquare:(BOOL)animate;

@end
