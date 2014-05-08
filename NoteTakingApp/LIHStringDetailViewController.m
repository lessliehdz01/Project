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
@property (nonatomic, strong) NSMutableArray *photoarray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *imageButton;


@end
//LIHTableViewController* tVC;
//@synthesize tableView;

@implementation LIHStringDetailViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string array:(NSMutableArray *)stringarray array:(NSMutableArray *)titlesarray array:(NSMutableArray *)photos
{
    if (self = [self initWithNibName:@"LIHStringDetailViewController" bundle:nil]) {
        self.string = string;
        self.row = row;
        self.stringarray = stringarray;
        self.titlearray = titlesarray;
        self.photoarray = photos;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //so image doesnt stretch out
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.title = [NSString stringWithFormat:@"%@", self.titlearray[self.row]];
    
    self.textView.text = self.string;
    self.imageView.image = self.photoarray[self.row];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.imageButton.target = self;
    self.imageButton.action = @selector(imageButtonPressed:);
    
    
}
-(IBAction)imageButtonPressed:(UIBarButtonItem*)sender{
 
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

-(void)doneButtonPressed:(UIBarButtonItem *)sender
{

    self.stringarray[self.row] = self.textView.text;
    [self.view endEditing:YES];
  
}

@end
