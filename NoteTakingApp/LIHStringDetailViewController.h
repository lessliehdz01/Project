//
//  LIHStringDetailViewController.h
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface LIHStringDetailViewController : UIViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string array:(NSMutableArray *)stringarray array:(NSMutableArray *)titlesarray  array:(NSMutableArray *)photosarray;

@end
