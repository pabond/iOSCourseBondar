//
//  BPVViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVViewController.h"

#import "BPVContext.h"

@implementation BPVViewController

#pragma mark -
#pragma mark Initializations and deallocations

- (void)dealloc {
    self.context = nil;
}

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setContext:(BPVContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [_context execute];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)loadModel {

}

@end
