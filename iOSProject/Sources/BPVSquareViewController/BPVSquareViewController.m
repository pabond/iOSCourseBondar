//
//  BPVSquareViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSquareViewController.h"

static const NSUInteger kBPVCornersCount = 4;

uint32_t randomNumberFrom(uint32_t number) {
    return arc4random_uniform(number);
}

@implementation BPVSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onAutoButton:(id)sender {
    BPVSquareView *square = self.squareView;
    BPVSquarePositionType type = square.squarePosition;
    type = type == BPVSquarePositionRightTop ? BPVSquarePositionLeftTop : type + 1;
    
    [square setSquarePosition:type animated:YES complitionHandler:^{
        
    }];
}

- (IBAction)onRandomButton:(id)sender {
    uint32_t randomNumber = 0;
    BPVSquarePositionType type = self.squareView.squarePosition;
    
    do {
        randomNumber = randomNumberFrom(kBPVCornersCount);
        if (randomNumber != type) {
            break;
        }
    } while (YES);
    
    
    [self.squareView setSquarePosition:randomNumber animated:YES complitionHandler:^{
        
    }];
}

@end
