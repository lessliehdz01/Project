//
//  LIHTableViewController.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHTableViewController.h"
#import "LIHInputViewController.h"
#import "LIHStringDetailViewController.h"

@interface LIHTableViewController () <UITableViewDataSource, UITableViewDelegate, LIHInputViewControllerDelegate>

//@property (nonatomic, strong, retain) UITableView *tableView;

//@property (nonatomic, strong) NSMutableArray *strings;

@end


@implementation LIHTableViewController


- (instancetype) init
{
    //if has no nib file
    if (self = [self initWithNibName:nil bundle:nil]) {
        // Custom initialization
        self.strings = [NSMutableArray array];
        self.titles = [NSMutableArray array];

    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   self.title = @"My Notes";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}
//reloads table view when navigating back to this table view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData]; // to reload selected cell
}

-(void)addButtonPressed:(UIBarButtonItem *)sender
{
    LIHInputViewController *inputVC = [[LIHInputViewController alloc]init];
    
    inputVC.delegate = self;
    
    [self presentViewController:inputVC animated:YES completion:nil];
}

#pragma mark - LIHInputViewControllerDelegate Methods

-(void)inputController:(LIHInputViewController *)controller didFinishWithText:(NSString *)text getTitle:(NSString *)title
{
    [self.strings addObject:text];
    [self.titles addObject:title];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifier"];
    if(!cell){
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"cellReuseIdentifier"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark -UITableViewDelegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIHStringDetailViewController *detailVC = [[LIHStringDetailViewController alloc]initWithRow:indexPath.row
                                                                    string:self.strings[indexPath.row]
                                                                    array:self.strings
                                                                    array:self.titles] ;
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData];
    
    
}

@end
