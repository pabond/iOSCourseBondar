//
//  BPVTableViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"

#import "BPVUsersView.h"
#import "BPVUserCell.h"
#import "BPVLoadingView.h"

#import "BPVArrayChange.h"

#import "BPVUser.h"

#import "BPVObservableObject.h"

#import "UITableView+BPVExtensions.h"
#import "BPVArrayChange+UITableView.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVTableTitle, USERS LIST);

BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)

@interface BPVTableViewController ()
@property (nonatomic, strong) BPVUsers *users;

@end

@implementation BPVTableViewController

#pragma mark -
#pragma mark Initalizations and deallocations

- (void)dealloc {
    [self.users removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.users load];
}

#pragma mark -
#pragma Public implementations

- (void)addModel:(id)model {
    self.users = model;
}

#pragma mark -
#pragma Interface Handling

- (IBAction)onAdd:(id)sender {
    [self.users addModel:[BPVUser new]];
}

- (IBAction)onEditing:(id)sender {
    self.usersView.editing = !self.usersView.editing;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.users removeModelAtIndex:indexPath.row];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return kBPVTableTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPVUserCell *cell = [tableView cellWithClass:[BPVUserCell class]];
    cell.user = self.users[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)    tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.users moveModelFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark BPVArrayModelObserver

- (void)arrayModelWillLoad:(id)arrayModel {
    self.usersView.loading = YES;
}

- (void)arrayModel:(id)collection didChangeWithModel:(BPVArrayChange *)changeModel {
    [changeModel applyToTableView:self.usersView.usersTableView];
}

- (void)arrayModelDidLoad:(id)arrayModel {
    [self.usersView.usersTableView reloadData];
    self.usersView.loading = NO;;
}

- (void)arrayModelFailLoading:(id)arrayModel {
    self.usersView.loading = NO;
}

@end
