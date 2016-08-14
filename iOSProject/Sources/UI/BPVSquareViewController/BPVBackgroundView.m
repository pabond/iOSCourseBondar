//
//  BPVBackgroundView.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBackgroundView.h"

#import "BPVMacro.h"

static const CGFloat    kBPVSquareSideSize      = 80.f;
static const CGFloat    kBPVAnimationDuration   = 0.8f;
static const CGFloat    kBPVAnimationDelay      = 0.0f;
static const NSUInteger kBPVCornersCount        = 4;

uint32_t BPVRandomWithCount(uint32_t count) {
    return arc4random_uniform(count);
}

@interface BPVBackgroundView ()

- (CGRect)squareWithType:(BPVSquarePositionType)type;
- (BPVSquarePositionType)nextSquarePosition;

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated;
- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler;

@end

@implementation BPVBackgroundView

#pragma mark -
#pragma mark Accessors

-(void)setSquarePosition:(BPVSquarePositionType)squarePosition {
    [self setSquarePosition:squarePosition animated:YES];
}

#pragma mark -
#pragma mark Public Implementations

- (void)startAutoAnimation {
    __weak id weakSelf = self;
    BPVSquarePositionType position = [weakSelf nextSquarePosition];
    [weakSelf setSquarePosition:position animated:YES complitionHandler:^{
        [weakSelf startAutoAnimation];
    }];
}

- (void)rundomSquarePostion {
    uint32_t randomPosition = 0;
    BPVSquarePositionType type = self.squarePosition;
    
    do {
        randomPosition = BPVRandomWithCount(kBPVCornersCount);
        if (randomPosition != type) {
            break;
        }
    } while (YES);
    
    [self setSquarePosition:randomPosition];
}

#pragma mark -
#pragma mark Privat Implementations

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated complitionHandler:nil];
}

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)complition {
    if (_squarePosition != squarePosition) {
        
        [UIView animateWithDuration:animated ? kBPVAnimationDuration : 0
                              delay:kBPVAnimationDelay
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{ self.squareView.frame = [self squareWithType:squarePosition]; }
                         completion:^(BOOL finished) {
                             _squarePosition = squarePosition;
                             if (complition && self.animating) {
                                 complition();
                             }
                         }];
    }
}

- (BPVSquarePositionType)nextSquarePosition {
    BPVSquarePositionType type = self.squarePosition;
    
    return type = (type == BPVSquarePositionRightTop) ? BPVSquarePositionLeftTop : type + 1;
}

- (CGRect)squareWithType:(BPVSquarePositionType)type {
    CGRect sqaure = CGRectMake(0, 0, kBPVSquareSideSize, kBPVSquareSideSize);
    CGRect frame = self.frame;
    
    switch (type) {
        case BPVSquarePositionLeftTop:
            break;
            
        case BPVSquarePositionRightButtom:
        case BPVSquarePositionRightTop:
            sqaure.origin.x = CGRectGetWidth(frame) - kBPVSquareSideSize;
            if (type == BPVSquarePositionRightTop) {
                break;
            }
            
        case BPVSquarePositionLeftButtom:
            sqaure.origin.y = CGRectGetHeight(frame) - kBPVSquareSideSize;
            break;
            
        default:
            break;
    }
    
    return sqaure;
}

@end
