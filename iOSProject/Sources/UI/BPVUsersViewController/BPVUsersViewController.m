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

#import "BPVUserCell.h"

#import "BPVUserViewController.h"

#import "BPVFriendsListContext.h"

#import "UITableView+BPVExtensions.h"
#import "BPVArrayChange+UITableView.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVEditingButton, Edit);
BPVStringConstantWithValue(kBPVDoneButton, Done);

BPVStringConstantWithValue(kBPVTableTitle, FRIENDS);
BPVViewControllerBaseViewPropertyWithGetter(BPVTableViewController, usersView, BPVUsersView)

@implementation BPVUsersViewController

#pragma mark -
#pragma mark Initializations and deallocations

- (void)dealloc {
    self.user = nil;
}

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    
    self.navigationItem.title = kBPVTableTitle;
    [self initBarButtons];
    
    return self;
}

- (void)initBarButtons {    
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithTitle:kBPVEditingButton
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(onEditing:)];
    
    [self.navigationItem setRightBarButtonItem:editingButton animated:YES];
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModel];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        _user = user;
        
        self.model = _user.friends;
        
        if ([self isViewLoaded]) {
            [self loadModel];
        }
    }
}

#pragma mark -
#pragma mark Interface Handling

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
    cell.user = self.model[indexPath.row];
    
    return cell;
}

- (BPVArrayModel *)modelFromSubclass {
    return [BPVUsers new];
}

#pragma mark -
#pragma mark Private Implementatoins

- (void)loadModel {
    BPVUser *user = self.user;
    self.model = user.friends;
    
    BPVFriendsListContext *context = [BPVFriendsListContext new];
    context.user = user;
    self.context = context;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BPVUserViewController *userController = [BPVUserViewController new];
    userController.user = self.model[indexPath.row];
    
    [self.navigationController pushViewController:userController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

#pragma mark -
#pragma mark BPVArrayModelChangeObserver

- (void)model:(BPVArrayModel *)model didChangeWithModel:(BPVArrayChange *)changeModel {
    [changeModel applyToTableView:self.usersView.usersTableView];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoadFriends:(id)model {
    self.usersView.loading = YES;
}

- (void)modelDidLoad:(id)model {
    [self.usersView.usersTableView reloadData];
    self.usersView.loading = NO;
}

- (void)modelFailLoading:(id)model {
    [self loadModel];    
    self.usersView.loading = NO;
}

#pragma mark -
#pragma mark BPVUserObserver

- (void)modelDidLoadFriends:(BPVUsers *)model {
    [self.usersView.usersTableView reloadData];
    self.usersView.loading = NO;
}

@end
