//
//  BPVTableViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"

#import "BPVLoadingView.h"

#import "BPVArrayChange.h"

#import "BPVUser.h"
#import "BPVUsers.h"

#import "BPVObservableObject.h"

#import "BPVMacro.h"

@implementation BPVTableViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.model = nil;
}

#pragma mark -
#pragma mark - ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModel];
}

#pragma mark -
#pragma mark Accessors

- (void)setModel:(BPVUsers *)model {
    if (_model != model) {
        [_model removeObservationWith:self];
        
        _model = model;
        [_model addObservationWith:self];
        
        if ([self isViewLoaded]) {
            [self loadModel];
        }
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.model removeModelAtIndex:indexPath.row];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)    tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.model moveModelFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

@end
