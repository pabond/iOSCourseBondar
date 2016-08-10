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

#import "BPVUser.h"
#import "BPVUserData.h"

#import "BPVObservableObject.h"

#import "BPVMacro.h"

static NSString * const kBPVTableTitle = @"USERS LIST";

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

- (void)loadView {
    [super loadView];
    
    BPVUsers *users = [[BPVUsers alloc] init];
    [users addObserver:self];
    self.users = users;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma Interface Handling

- (IBAction)onEdit:(id)sender {
    self.editButton.hidden = YES;
    self.doneButton.hidden = NO;
    
    self.usersView.usersTableView.editing = YES;
}

- (IBAction)onAdd:(id)sender {
    [self.users addUser:[BPVUser new]];
}

- (IBAction)onDone:(id)sender {
    self.doneButton.hidden = YES;
    self.editButton.hidden = NO;
    
    self.usersView.usersTableView.editing = NO;
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
        [self.users removeUserAtIndex:indexPath.row notify:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return kBPVTableTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellClass = NSStringFromClass([BPVUserCell class]);
    
    BPVUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:cellClass bundle:nil];
        NSArray *cells = [nib instantiateWithOwner:nil options:nil];
        cell = [cells firstObject];
    }
    
    NSUInteger row = indexPath.row;
    BPVUsers *users = self.users;
    BPVUser *user = [users userAtIndex:row];
    if (!user) {
        user = [BPVUser new];
        [users addUser:user];
        user.surname = [NSString stringWithFormat:@"%@ %ld", user.surname, (long)indexPath.row];
    }
    
    cell.user = user;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.users moveUserFromSourceIndex:sourceIndexPath.row destinationIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark BPVCollectionObserver
- (void)collection:(BPVUsers *)collection didUpdateWithUserData:(BPVUserData *)data {
    UITableView *table = self.usersView.usersTableView;
    NSUInteger usersCount = collection.count;
    NSUInteger cellsCount = [table numberOfRowsInSection:0];
 
    NSUInteger index = data.userIndex;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (usersCount > cellsCount) {
        [table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    } else if (usersCount < cellsCount) {
        [table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

@end
