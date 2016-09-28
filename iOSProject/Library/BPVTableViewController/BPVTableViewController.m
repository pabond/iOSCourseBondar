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
#import "BPVFilteredModel.h"

#import "BPVUser.h"
#import "BPVUsers.h"

#import "BPVFriendsListContext.h"

#import "BPVObservableObject.h"

#import "BPVMacro.h"

@interface BPVTableViewController ()
@property (nonatomic, strong) BPVFilteredModel *filteredModel;

@end

@implementation BPVTableViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.filteredModel = nil;
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

- (void)setUser:(BPVUser *)user {
    if (_user !=  user) {
        _user = user;
        
        self.model = [BPVUsers new];
    }
}

- (void)setModel:(BPVArrayModel *)model {
    if (_model != model) {
        _model = model;
        
        self.filteredModel = [BPVFilteredModel filteredModelWithArrayModel:_model];
        
//        if ([self isViewLoaded]) {
            [self loadModel];
//        }
    }
}

- (void)setFilteredModel:(BPVFilteredModel *)filteredModel {
    if (_filteredModel != filteredModel) {
        [_filteredModel removeObserver:self];
        
        _filteredModel = filteredModel;
        [_filteredModel addObserver:self];
    }
}

#pragma mark -
#pragma mark PublicImplementations

- (void)loadModel {
    BPVFriendsListContext *context = [BPVFriendsListContext new];
    context.user = self.user;
    context.model = self.model;
    self.context = context;
    
    [context execute];
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
    return self.model.count == self.filteredModel.count;
}

- (void)    tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
          toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.model moveModelFromIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

@end
