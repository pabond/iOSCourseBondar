//
//  BPVUsersViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersViewController.h"

#import "BPVUsersView.h"
#import "BPVUser.h"

#import "BPVUserCell.h"

#import "UITableView+BPVExtensions.h"
#import "BPVArrayChange+UITableView.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVTableTitle, USERS LIST);
BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)

@interface BPVUsersViewController ()

@end

@implementation BPVUsersViewController

#pragma mark -
#pragma Interface Handling

- (IBAction)onAdd:(id)sender {
    [self.model addModel:[BPVUser new]];
}

- (IBAction)onEditing:(id)sender {
    self.usersView.editing = !self.usersView.editing;
}

#pragma mark -
#pragma mark Public Implementatoins

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPVUserCell *cell = [tableView cellWithClass:[BPVUserCell class]];
    cell.user = self.model[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return kBPVTableTitle;
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)model:(id)model didChangeWithModel:(BPVArrayChange *)changeModel {
    [changeModel applyToTableView:self.usersView.usersTableView];
}

- (void)modelWillLoad:(id)model {
    self.usersView.loading = YES;
}

- (void)modelDidLoad:(id)model {
    [self.usersView.usersTableView reloadData];
    self.usersView.loading = NO;
}

- (void)modelFailLoading:(id)model {
    self.usersView.loading = NO;
}

@end
