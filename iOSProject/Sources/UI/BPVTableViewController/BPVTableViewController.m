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

#import "BPVObservableObject.h"

#import "BPVMacro.h"

static NSString * const kBPVTableTitle = @"USERS LIST";

typedef enum {
    BPVEditingStyleDelete,
    BPVEditingStyleAdd
} BPVEditingStyleType;

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
    self.addRemoveControl.hidden = NO;
    self.addButton.hidden = YES;
    
    self.usersView.usersTableView.editing = YES;
}

- (IBAction)onDone:(id)sender {
    self.doneButton.hidden = YES;
    self.addRemoveControl.hidden = YES;
    self.editButton.hidden = NO;
    self.addButton.hidden = NO;
    
    self.usersView.usersTableView.editing = NO;
}

- (IBAction)onAddRemove:(id)sender {
    
}

- (IBAction)onAdd:(id)sender {
    [self.users addUser:[BPVUser new]];
}

#pragma mark -
#pragma mark UITableViewDelegate

/*
UITableViewCellEditingStyleNone,
UITableViewCellEditingStyleDelete,
UITableViewCellEditingStyleInsert
*/

#pragma mark -
#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.users removeUserAtIndex:indexPath.row];
        [self.usersView.usersTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    } else {
        [self.usersView.usersTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return kBPVTableTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.users.count;;
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

- (void)collectionDidChange:(id)collection {
    [self.usersView.usersTableView reloadData];
}

@end
