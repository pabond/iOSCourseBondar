//
//  BPVSquareViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSquareViewController.h"

@interface BPVSquareViewController ()

@end

@implementation BPVSquareViewController

-(void)setSquarePosition:(BPVSquarePositionType)squarePosition {
    CGRect square = squarePosition;
    if (!CGRectEqualToRect(self.squareView.frame, square)) {
        self.squarePosition = squarePosition;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"Memory warning");
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onAutoButton:(id)sender {
    [self.squareView animateSquare:YES];
}

- (IBAction)onRandomButton:(id)sender {
    
}

@end
