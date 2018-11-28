//
//  SVPFilesViewController.m
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "SVPAppNavigationController.h"
#import "SVPFilesItem.h"
#import "SVPFilesViewController.h"

@import os.log;

NS_ASSUME_NONNULL_BEGIN

@interface SVPFilesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly, nullable) SVPAppNavigationController *navigationController;

@property (nonatomic, nullable) UITableView *tableView;
@property (nonatomic, nullable) NSArray<SVPFilesItem *> *items;

@end

@implementation SVPFilesViewController

static NSString * const kCellReuseIdentifier = @"SVPFilesViewControllerTableViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray<NSLayoutConstraint *> * const constraints = [[NSMutableArray alloc] init];

    UITableView * const tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellReuseIdentifier];

    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [constraints addObject:[tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor]];
    [constraints addObject:[tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]];
    [constraints addObject:[tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]];
    [constraints addObject:[tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]];

    [self.view addSubview:tableView];
    self.tableView = tableView;

    [NSLayoutConstraint activateConstraints:constraints];

    [self _svp_main_reloadData];
}

// MARK: - Properties

@dynamic navigationController;

- (void)setPath:(nullable NSString *)path
{
    if (_path == path || [_path isEqualToString:path]) {
        return;
    }
    _path = [path copy];

    self.title = _path.lastPathComponent;

    [self _svp_main_reloadData];
}

- (void)_svp_main_reloadData
{
    if (!self.viewLoaded) {
        return;
    }

    if (!self.path) {
        self.items = @[];
        return;
    }

    NSMutableArray<SVPFilesItem *> * const items = [[NSMutableArray alloc] init];
    NSError *error;
    NSArray<NSString *> * const contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    if (error) {
        os_log_error(OS_LOG_DEFAULT, "Failed to list contents of directory at path: %@ error: %@", self.path, error);
        return;
    }

    for (NSString * const content in contents) {
        NSString * const path = [self.path stringByAppendingPathComponent:content];
        SVPFilesItem * const item = [[SVPFilesItem alloc] initWithPath:path];
        [items addObject:item];
    }
    self.items = [items copy];
}

- (void)setItems:(nullable NSArray<SVPFilesItem *> *)items
{
    if (_items == items) {
        return;
    }
    _items = items;

    [self.tableView reloadData];
}

// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * const cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    const NSUInteger index = indexPath.row;
    NSAssert((index < self.items.count), @"indexPath should be in items range.");
    if (!(index < self.items.count)) {
        return nil;
    }

    SVPFilesItem * const item = self.items[index];
    if (item.directory) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = item.path.lastPathComponent;

    return cell;
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    const NSUInteger index = indexPath.row;
    NSAssert((index < self.items.count), @"indexPath should be in items range.");
    if (!(index < self.items.count)) {
        return;
    }

    SVPFilesItem * const item = self.items[index];

    if (item.directory) {
        SVPFilesViewController * const filesViewController = [[SVPFilesViewController alloc] init];
        filesViewController.path = item.path;
        [self.navigationController pushViewController:filesViewController animated:YES];
        return;
    }

    if (!item.audioVisualContent) {
        return;
    }

    NSURL * const URL = [NSURL fileURLWithPath:item.path];
    [self.navigationController presentAVPlayerWithItemAtURL:URL];
}

@end

NS_ASSUME_NONNULL_END
