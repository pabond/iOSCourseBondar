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
static const CGFloat    kBPVAnimationDelay      = 1.f;
static const NSUInteger kBPVCornersCount        = 4;

uint32_t randomNumberFrom(uint32_t number) {
    return arc4random_uniform(number);
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
    [self setSquarePosition:squarePosition animated:NO];
}

#pragma mark -
#pragma mark Public Implementations

- (void)startAutoAnimation {
    __weak id weakSelf = self;
    [self setSquarePosition:[self nextSquarePosition] animated:YES complitionHandler:^{
        [weakSelf startAutoAnimation];
    }];
}

- (void)rundomSquarePostion {
    uint32_t randomPosition = 0;
    BPVSquarePositionType type = self.squarePosition;
    
    do {
        randomPosition = randomNumberFrom(kBPVCornersCount);
        if (randomPosition != type) {
            break;
        }
    } while (YES);
    
    [self setSquarePosition:randomPosition];
}


#pragma mark -
#pragma mark Privat Implementations

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated complitionHandler:NULL];
}

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler {
    if (_squarePosition != squarePosition) {
        [UIView animateWithDuration:kBPVAnimationDuration animations:^{
            self.squareView.frame = [self squareWithType:squarePosition];
        }];
        
        _squarePosition = squarePosition;
        
        if (handler && self.animated) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBPVAnimationDelay * NSEC_PER_SEC)),
                           dispatch_get_main_queue(),
                           ^{ handler(); });
        }
    }
}

- (BPVSquarePositionType)nextSquarePosition {
    BPVSquarePositionType type = self.squarePosition;
    
    return type = type == BPVSquarePositionRightTop ? BPVSquarePositionLeftTop : type + 1;
}

- (CGRect)squareWithType:(BPVSquarePositionType)type {
    CGRect sqaure = CGRectMake(0, 0, kBPVSquareSideSize, kBPVSquareSideSize);
    
    switch (type) {
        case BPVSquarePositionLeftTop:
            break;
            
        case BPVSquarePositionRightButtom:
        case BPVSquarePositionRightTop:
            sqaure.origin.x = CGRectGetWidth(self.frame) - kBPVSquareSideSize;
            if (type == BPVSquarePositionRightTop) {
                break;
            }
            
        case BPVSquarePositionLeftButtom:
            sqaure.origin.y = CGRectGetHeight(self.frame) - kBPVSquareSideSize;
            break;
            
        default:
            break;
    }
    
    return sqaure;
}

@end
