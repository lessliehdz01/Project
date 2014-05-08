//
//  LIHInputViewController.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHInputViewController.h"

@interface LIHInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *Title;

@end

@implementation LIHInputViewController

-(instancetype)init
{
    if (self = [self initWithNibName:@"LIHInputViewController" bundle:nil]) {
        // more config here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textField addTarget:self
                       action:@selector(textFieldDidFinish:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textField.returnKeyType = UIReturnKeyDone;
    
}


- (void)textFieldDidFinish:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        [self.delegate inputController:self didFinishWithText:textField.text getTitle:self.Title.text];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Warning!"
                                    message:@"You must have a non-empty string to continue."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
