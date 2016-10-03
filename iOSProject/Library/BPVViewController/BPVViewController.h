//
//  BPVViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPVViewController : UIViewController
//setting of this property calls context execute;
@property (nonatomic, strong)   id  context;

- (void)loadModel;

@end
