//
//  BPVSquareView.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSquareView.h"

#import "BPVMacro.h"

static const CGFloat kBPVSquareSideSize = 100;

@interface BPVSquareView ()

- (CGRect)squareWithType:(BPVSquarePositionType)type;

@end

@implementation BPVSquareView

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

//- (void)setSquarePosition:(BPVSquarePositionType)squarePosition animated:(BOOL)animated complitionHandler:(BPVHandler)handler {
//    
//    if (handler) {
//        
//    }
//    
//    CGRect square = squarePosition;
//    if (!CGRectEqualToRect(self.square.frame, square)) {
//        self.squarePosition = squarePosition;
//    }
//    
//    self.square.frame = square;
//}

- (void)animateSquare:(BOOL)animate {

}

#pragma mark -
#pragma mark Privat Implementations

- (CGRect)squareWithType:(BPVSquarePositionType)type {
    switch (type) {
        case BPVSquarePositionLeftTop:
            return CGRectMake(0, 0, kBPVSquareSideSize, kBPVSquareSideSize);
        case BPVSquarePositionRightTop:
            return CGRectMake(220, 0, kBPVSquareSideSize, kBPVSquareSideSize);
        case BPVSquarePositionLeftButtom:
            return CGRectMake(0, 468, kBPVSquareSideSize, kBPVSquareSideSize);
        case BPVSquarePositionRightButtom:
            return CGRectMake(220, 468, kBPVSquareSideSize, kBPVSquareSideSize);
        default:
            break;
    }
}

@end
