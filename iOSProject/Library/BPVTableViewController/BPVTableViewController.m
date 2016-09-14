//
//  BPVTableViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"
#import "BPVUserCell.h"
#import "BPVLoadingView.h"

#import "BPVArrayChange.h"
#import "BPVFilteredModel.h"

#import "BPVObservableObject.h"

#import "BPVMacro.h"

@interface BPVTableViewController ()
@property (nonatomic, strong) BPVFilteredModel *filteredModel;
@property (nonatomic, strong) BPVArrayModel    *model;

@end

@implementation BPVTableViewController

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithNibName:(nullable NSString *)nibName bundle:(nullable NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    BPVArrayModel *model = [self modelFromSubclass];
    self.model = model;
    self.filteredModel = [BPVFilteredModel filteredModelWithRootModel:model];
    
    if ([self isViewLoaded]) {
        [model load];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setFilteredModel:(BPVFilteredModel *)filteredModel {
    if (_filteredModel != filteredModel) {
        [_filteredModel removeObserver:self];
        
        _filteredModel = filteredModel;
        [_filteredModel addObserver:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.model load];
}

#pragma mark -
#pragma mark Public implementations 

- (BPVArrayModel *)modelFromSubclass {
    return nil;
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
