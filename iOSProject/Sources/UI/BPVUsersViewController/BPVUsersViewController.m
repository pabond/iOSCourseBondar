//
//  BPVUsersViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersViewController.h"

#import "BPVUsersView.h"
#import "BPVUsers.h"
#import "BPVUser.h"

#import "BPVUserCell.h"

#import "UITableView+BPVExtensions.h"
#import "BPVArrayChange+UITableView.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVTableTitle, USERS LIST);
BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)

@implementation BPVUsersViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onAdd:(id)sender {
    [self.model addModel:[BPVUser new]];
}

- (IBAction)onSearchFieldEdit:(UITextField *)sender {
    [self.filteredModel filterArrayWithSting:sender.text];
}

- (IBAction)onEditing:(id)sender {
    BPVUsersView *usersView = self.usersView;
    usersView.editing = !usersView.editing;
}

#pragma mark -
#pragma mark Public Implementatoins

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPVUserCell *cell = [tableView cellWithClass:[BPVUserCell class]];
    cell.user = self.filteredModel[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredModel.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return kBPVTableTitle;
}

#pragma mark -
#pragma mark BPVArrayModelChangeObserver

- (void)model:(id)model didChangeWithModel:(BPVArrayChange *)changeModel {
    [changeModel applyToTableView:self.usersView.usersTableView];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(id)model {
    self.usersView.loading = YES;
}

- (void)modelDidLoad:(BPVArrayModel *)model {
    [self.usersView.usersTableView reloadData];
    self.usersView.loading = NO;
}

- (void)modelFailLoading:(id)model {
    self.usersView.loading = NO;
}

#pragma mark -
#pragma mark BPVFilteredModelObserver

- (void)modelDidFilter:(id)model {
    [self.usersView.usersTableView reloadData];
}

@end
