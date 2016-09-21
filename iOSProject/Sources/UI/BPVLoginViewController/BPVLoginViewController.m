//
//  BPVLoginViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginViewController.h"

#import "BPVLoginView.h"
#import "BPVImage.h"

#import "BPVMacro.h"

static NSString * const kBPVImageURL = @"http://www.userlogos.org/files/logos/jumpordie/facebook_04.png";

BPVViewControllerBaseViewPropertyWithGetter(BPVLoginViewController, loginView, BPVLoginView)

@implementation BPVLoginViewController

- (instancetype)initWithNibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    
    BPVImage *image = [BPVImage imageWithUrl:[NSURL URLWithString:kBPVImageURL]];
    BPVLoginView *loginView = self.loginView;
    loginView.imageView.image = image;
    
    return self;
}


@end
