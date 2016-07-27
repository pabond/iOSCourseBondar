//
//  BPVSquareViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPVSquareView.h"

@interface BPVSquareViewController : UIViewController
@property (nonatomic, strong) IBOutlet BPVSquareView    *squareView;

@property (nonatomic, strong) IBOutlet UIButton *autoAnimation;
@property (nonatomic, strong) IBOutlet UIButton *randomSquarePosition;

- (IBAction)onAutoButton:(id)sender;
- (IBAction)onRandomButton:(id)sender;

@end
