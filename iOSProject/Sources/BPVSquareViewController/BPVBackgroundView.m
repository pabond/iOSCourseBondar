//
//  BPVBackgroundView.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/29/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBackgroundView.h"

#import "BPVMacro.h"

static const CGFloat    kBPVSquareSideSize      = 80;
static const CGFloat    kBPVAnimationDuration   = 1;
static const NSUInteger kBPVCornersCount        = 4;

uint32_t randomNumberFrom(uint32_t number) {
    return arc4random_uniform(number);
}

@interface BPVBackgroundView ()

- (CGRect)squareWithType:(BPVSquarePositionType)type;

@end

@implementation BPVBackgroundView

#pragma mark -
#pragma mark Accessors

-(void)setSquarePosition:(BPVSquarePositionType)squarePosition {
    [self setSquarePosition:squarePosition animated:NO];
}

//- (void)squarePosition {
//}

#pragma mark -
#pragma mark Public Implementations

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated {
    [self setSquarePosition:squarePosition animated:animated complitionHandler:NULL];
}

- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler {
    if (_squarePosition != squarePosition) {
        if (animated) {
            [UIView animateKeyframesWithDuration:kBPVAnimationDuration
                                           delay:0.0
                                         options:UIViewKeyframeAnimationOptionLayoutSubviews
                                      animations:^{
                                          [self.squareView setFrame:[self squareWithType:squarePosition]];
                                      }
                                      completion:^(BOOL finished) {
                                          NSLog(@"Animation complete");
                                          _squarePosition = squarePosition;
                                      }];
        }
        
        CGRect frame = [self squareWithType:squarePosition];
        self.squareView.frame = frame;
        NSLog(@"%@", self);
    }
}

- (BPVSquarePositionType)nextSquarePosition {
    BPVSquarePositionType type = self.squarePosition;
    
    return type = type == BPVSquarePositionRightTop ? BPVSquarePositionLeftTop : type + 1;
}

- (BPVSquarePositionType)rundomSquarePostion {
    uint32_t randomPosition = 0;
    BPVSquarePositionType type = self.squarePosition;

    do {
        randomPosition = randomNumberFrom(kBPVCornersCount);
        if (randomPosition != type) {
            break;
        }
    } while (YES);
    
    return randomPosition;
}

#pragma mark -
#pragma mark Privat Implementations

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
