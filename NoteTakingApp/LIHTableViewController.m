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
@property (nonatomic, strong) NSArray *tempstrings;

@end


@implementation LIHTableViewController


- (instancetype) init
{
    
    
    //if has no nib file
    if (self = [self initWithNibName:nil bundle:nil]) {
        // Custom initialization
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *stringsPath = [docPath stringByAppendingPathComponent:@"strings"];
        NSString *titlePath = [docPath stringByAppendingPathComponent:@"titles"];
        NSString *imagesPath = [docPath stringByAppendingPathComponent:@"imges"];
        NSFileManager*  fileManager = [NSFileManager defaultManager];
        
        if([fileManager fileExistsAtPath:imagesPath]){
            NSLog(@"Plist file exists at expected location.");
            self.strings = [NSMutableArray arrayWithContentsOfFile:stringsPath];
            self.titles = [NSMutableArray arrayWithContentsOfFile:titlePath];
            self.photos = [NSKeyedUnarchiver unarchiveObjectWithFile:imagesPath];//[NSMutableArray arrayWithContentsOfFile:imagesPath];
            int size = [self.photos count];
            NSLog(@"there are %d objects in the array", size);
        }
        else{
        self.strings = [NSMutableArray array];
        self.titles = [NSMutableArray array];
        self.photos = [NSMutableArray array];
        }
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
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *stringsPath = [docPath stringByAppendingPathComponent:@"strings"];
    NSString *titlePath = [docPath stringByAppendingPathComponent:@"titles"];
    NSString *imagesPath = [docPath stringByAppendingPathComponent:@"images"];
    if([self.strings writeToFile:stringsPath atomically:YES])
    {
        NSLog(@"write");
    }
    if([self.titles writeToFile:titlePath atomically:YES])
    {
        NSLog(@"write2");
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.photos];
    [data writeToFile:imagesPath options:NSDataWritingAtomic error:nil];


}



-(void)addButtonPressed:(UIBarButtonItem *)sender
{
    LIHInputViewController *inputVC = [[LIHInputViewController alloc]init];
    
    inputVC.delegate = self;

    
    [self.navigationController pushViewController:inputVC animated:YES];
}

#pragma mark - LIHInputViewControllerDelegate Methods

-(void)inputController:(LIHInputViewController *)controller didFinishWithText:(NSString *)text getTitle:(NSString *)title getPhoto:(NSObject *)photo
{

    [self.strings addObject:text];
    [self.titles addObject:title];
    [self.photos addObject:photo];
    [self.tableView reloadData];
 
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
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"MM/dd/yyyy  HH:mm a"];
    NSString *Date = [dateFormatter stringFromDate:date];
    
    
    
    NSString *s = self.titles[indexPath.row];
    s = [s stringByAppendingString: @"   "];
    s = [s stringByAppendingString: Date];
    cell.textLabel.text = s;
    return cell;
}

#pragma mark -UITableViewDelegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIHStringDetailViewController *detailVC = [[LIHStringDetailViewController alloc]initWithRow:indexPath.row
                                                                    string:self.strings[indexPath.row]
                                                                    array:self.strings
                                                                    array:self.titles
                                                                    array:self.photos] ;
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData];
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [self.strings removeObjectAtIndex:indexPath.row];
        [self.titles removeObjectAtIndex:indexPath.row];
        [self.photos removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

@end
