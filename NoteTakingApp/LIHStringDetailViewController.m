//
//  LIHStringDetailViewController.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHStringDetailViewController.h"
#import "LIHTableViewController.h"

@interface LIHStringDetailViewController ()<MFMailComposeViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSString *string;
@property (nonatomic) NSInteger row;
@property (nonatomic, strong) NSMutableArray *stringarray;
@property (nonatomic, strong) NSMutableArray *titlearray;
@property (nonatomic, strong) NSMutableArray *photoarray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *imageButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *emailButton;

@end


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
    self.emailButton.target = self;
    self.emailButton.action = @selector(emailButtonPressed:);
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.imageButton.target = self;
    self.imageButton.action = @selector(imageButtonPressed:);
    
  
    
    
}
//email actions
-(IBAction)emailButtonPressed:(UIBarButtonItem*)sender{
    // email title
    NSString *emailTitle = self.title;
    // Email Content
    NSString *messageBody = self.textView.text;
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"lih2105@columbia.edu"];
    
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.mailComposeDelegate = self;
    [mailVC setSubject:emailTitle];
    [mailVC setMessageBody:messageBody isHTML:NO];
    NSData *imageData = [[NSData alloc]initWithData:UIImagePNGRepresentation(self.imageView.image)];
    [mailVC addAttachmentData:imageData mimeType:@"image/jpeg" fileName:self.title];
    [mailVC setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mailVC animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [[[UIAlertView alloc] initWithTitle:@"CANCELLED"
                                        message:@"Your email was not sent!"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
            break;
        case MFMailComposeResultSaved:
            [[[UIAlertView alloc] initWithTitle:@"SAVED"
                                        message:@" "
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            break;
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle:@"SUCCESS!"
                                        message:@"Your email has been sent!."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


//image actions
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
