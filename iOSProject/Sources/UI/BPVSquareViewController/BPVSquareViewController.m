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

@implementation BPVSquareViewController

#pragma mark -
#pragma Interface Handling

- (IBAction)onAutoButton:(id)sender {
    BPVBackgroundView *backgroundView = self.backgroundView;
    if (!backgroundView.animated) {
        backgroundView.animated = YES;
        [backgroundView startAutoAnimation];
        
        return;
    }
    
    backgroundView.animated = NO;
}

- (IBAction)onRandomButton:(id)sender {
    [self.backgroundView rundomSquarePostion];
}

@end
