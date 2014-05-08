//
//  LIHStringDetailViewController.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHStringDetailViewController.h"
#import "LIHTableViewController.h"

@interface LIHStringDetailViewController ()



@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSString *string;
@property (nonatomic) NSInteger row;
@property (nonatomic, strong) NSMutableArray *stringarray;
@property (nonatomic, strong) NSMutableArray *titlearray;



@end
//LIHTableViewController* tVC;
//@synthesize tableView;

@implementation LIHStringDetailViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string array:(NSMutableArray *)stringarray array:(NSMutableArray *)titlesarray
{
    if (self = [self initWithNibName:@"LIHStringDetailViewController" bundle:nil]) {
        self.string = string;
        self.row = row;
        self.stringarray = stringarray;
        self.titlearray = titlesarray;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@", self.titlearray[self.row]];
    
    self.textView.text = self.string;
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(void)doneButtonPressed:(UIBarButtonItem *)sender
{
    LIHTableViewController* tVC = [[LIHTableViewController alloc] init];
    //[tVC.strings addObject:self.textView.text];
    self.stringarray[self.row] = self.textView.text;
    [self.view endEditing:YES];
    //NSLog(@"%@",tVC.strings[0]);
    [tVC.tableView reloadData];
    NSLog(@"%@",self.stringarray[self.row]);
}

@end
