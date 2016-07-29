//
//  BPVSquareViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSquareViewController.h"

#import "BPVBackgroundView.h"

#import "BPVMacro.h"

BPVViewControllerBaseViewPropertyWithGetter(BPVSquareViewController, backgroundView, BPVBackgroundView)

@interface BPVSquareViewController ()

- (void)setPositionAnimatedWithType:(BPVSquarePositionType)type;
- (void)setPositionAnimatedWithType:(BPVSquarePositionType)type handler:(BPVHandler)handler;

@end

@implementation BPVSquareViewController

#pragma mark -
#pragma Interface Handling

- (IBAction)onAutoButton:(id)sender {
    [self setPositionAnimatedWithType:[self.backgroundView nextSquarePosition]];
}

- (IBAction)onRandomButton:(id)sender {
    [self setPositionAnimatedWithType:[self.backgroundView rundomSquarePostion]];
}

#pragma mark -
#pragma Private implementations

- (void)setPositionAnimatedWithType:(BPVSquarePositionType)type {
    [self.backgroundView setSquarePosition:type animated:YES];
}

- (void)setPositionAnimatedWithType:(BPVSquarePositionType)type handler:(BPVHandler)handler {
    [self.backgroundView setSquarePosition:type animated:YES complitionHandler:handler];
}

@end
