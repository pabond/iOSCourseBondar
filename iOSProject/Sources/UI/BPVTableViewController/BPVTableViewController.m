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

BPVStringConstant(kBPVTableTitle, @"USERS LIST");

BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)
BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, loadingView, BPVLoadingView)

@interface BPVTableViewController ()
@property (nonatomic, strong) BPVUsers *users;

@end

@implementation BPVTableViewController

#pragma mark -
#pragma mark Initalizations and deallocations

- (void)dealloc {
    [self.users removeObserver:self];
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.users load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma Public implementations

- (void)addModel:(id)model {
    self.users = model;
}

#pragma mark -
#pragma Interface Handling

- (IBAction)onEdit:(id)sender {
    self.usersView.editing = YES;
}

- (IBAction)onAdd:(id)sender {
    [self.users addModel:[BPVUser new]];
}

- (IBAction)onDone:(id)sender {
    self.usersView.editing = NO;
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
        [self.users removeModelAtIndex:indexPath.row notify:YES];
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
    cell.user = [self.users modelAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.users moveModelFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark BPVCollectionObserver

- (void)collection:(id)collection didUpdateWithArrayChangeModel:(BPVArrayChange *)changeModel {
    [changeModel applyToTableView:self.usersView.usersTableView];
}

@end
