//
//  LIHTableViewController.h
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIHTableViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *strings;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong, retain) UITableView *tableView;

@end
