//
//  LIHInputViewController.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHInputViewController.h"

@interface LIHInputViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Photo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    
    
    //make title limited characters
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(check) userInfo:nil repeats:YES ];
    //add done button to finish edting and save
     UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.Photo.target = self;
    self.Photo.action = @selector(imageButtonPressed:);
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}
//only saves note when the nav goes back
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        NSLog(@"check");
            if (![self.notes.text isEqualToString:@""]) {
                [self.delegate inputController:self didFinishWithText:self.notes.text getTitle:self.Title.text];
                [self.notes resignFirstResponder];
            } 
    }
    [super viewWillDisappear:animated];
}

//cuts off title so it isnt too long
-(void)check{
    if([self.Title.text length]>=15){
        self.Title.text = [self.Title.text substringWithRange:NSMakeRange(0, 14)];
    }
}
-(IBAction)imageButtonPressed:(UIBarButtonItem*)sender{
    NSLog(@"What");
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker
                       animated:YES
                     completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image= image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//gets rid of the keyboard
-(void)doneButtonPressed:(UIBarButtonItem *)sender{

    [self.notes resignFirstResponder];
    [self.Title resignFirstResponder];
}



@end
