//
//  BPVSquareView.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSquareView.h"

#import "BPVMacro.h"

static const CGFloat kBPVSquareSideSize = 80;
static const CGFloat kBPVAnimationDuration = 1;

@interface BPVSquareView ()

- (CGRect)squareWithType:(BPVSquarePositionType)type;

@end

@implementation BPVSquareView

#pragma mark -
#pragma mark Accessors


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

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
    if (handler) {
        handler();
    }
    
    if (_squarePosition != squarePosition) {
        if (animated) {
            CGRect sqaure = [self squareWithType:squarePosition];
            
            [UIView animateKeyframesWithDuration:kBPVAnimationDuration
                                           delay:0.0
                                         options:UIViewKeyframeAnimationOptionLayoutSubviews
                                      animations:^{
                                          self.transform = CGAffineTransformTranslate(self.transform,
                                                                                      sqaure.origin.x,
                                                                                      sqaure.origin.y);
                                      }
                                      completion:^(BOOL finished) {
                                          NSLog(@"Animation complete");
                                          _squarePosition = squarePosition;
                                      }];
        }
        
        CGRect frame = [self squareWithType:squarePosition];
        self.frame = frame;
        NSLog(@"%@", self);
    }
}


#pragma mark -
#pragma mark Privat Implementations

- (CGRect)squareWithType:(BPVSquarePositionType)type {
    switch (type) {
        case BPVSquarePositionLeftTop:
            return CGRectMake(0, 0, kBPVSquareSideSize, kBPVSquareSideSize);
            
        case BPVSquarePositionRightTop:
            return CGRectMake(CGRectGetWidth(self.window.frame) - kBPVSquareSideSize,
                              0,
                              kBPVSquareSideSize,
                              kBPVSquareSideSize);
            
        case BPVSquarePositionLeftButtom:
            return CGRectMake(0,
                              CGRectGetHeight(self.window.frame) - kBPVSquareSideSize,
                              kBPVSquareSideSize,
                              kBPVSquareSideSize);
            
        case BPVSquarePositionRightButtom:
            return CGRectMake(CGRectGetWidth(self.window.frame) - kBPVSquareSideSize,
                              CGRectGetHeight(self.window.frame) - kBPVSquareSideSize,
                              kBPVSquareSideSize,
                              kBPVSquareSideSize);
            
        default:
            break;
    }
}

@end
