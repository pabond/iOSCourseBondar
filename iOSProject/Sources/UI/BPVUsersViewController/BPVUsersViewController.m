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

BPVStringConstantWithValue(kBPVEditingButton, Edit);
BPVStringConstantWithValue(kBPVDoneButton, Done);

BPVStringConstantWithValue(kBPVTableTitle, USERS LIST);
BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)

@interface BPVTableViewController ()
@property (nonatomic, strong) BPVFilteredModel *filteredModel;

@end

@implementation BPVUsersViewController

#pragma mark -
#pragma mark Initializations and deallocations

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title = kBPVTableTitle;
    [self initBarButtons];
}

- (void)initBarButtons {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(onAdd:)];
    [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithTitle:kBPVEditingButton
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(onEditing:)];
    
    [self.navigationItem setRightBarButtonItem:editingButton animated:YES];
}

#pragma mark -
#pragma mark Interface Handling

- (void)onAdd:(id)sender {
    [self.model addModel:[BPVUser new]];
}

- (IBAction)onSearchFieldEdit:(UITextField *)sender {
    [self.filteredModel filterArrayWithString:sender.text];
}

- (void)onEditing:(id)sender {
    BPVUsersView *usersView = self.usersView;
    BOOL editing = !usersView.editing;
    usersView.editing = editing;
    self.navigationItem.rightBarButtonItem.title =  editing ? kBPVDoneButton : kBPVEditingButton;
}

#pragma mark -
#pragma mark Public Implementatoins

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPVUserCell *cell = [tableView cellWithClass:[BPVUserCell class]];
    cell.user = self.filteredModel[indexPath.row];
    
    return cell;
}

- (BPVArrayModel *)modelFromSubclass {
    return [BPVUsers new];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredModel.count;
}

#pragma mark -
#pragma mark BPVArrayModelChangeObserver

- (void)model:(BPVArrayModel *)model didChangeWithModel:(BPVArrayChange *)changeModel {
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
