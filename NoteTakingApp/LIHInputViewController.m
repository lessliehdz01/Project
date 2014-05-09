//
//  LIHInputViewControl/Users/lessliehernandez/college:columbia/NoteTakingApp/NoteTakingApp/LIHStringDetailViewController.mler.m
//  NoteTakingApp
//
//  Created by Lesslie Hernandez on 5/7/14.
//  Copyright (c) 2014 Lesslie Hernandez. All rights reserved.
//

#import "LIHInputViewController.h"

@interface LIHInputViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Photo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *emailButton;

@end

@implementation LIHInputViewController

-(instancetype)init
{
    if (self = [self initWithNibName:@"LIHInputViewController" bundle:nil]) {
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
    //set up buttons for actions
    self.Photo.target = self;
    self.Photo.action = @selector(imageButtonPressed:);
    self.emailButton.target = self;
    self.emailButton.action = @selector(emailButtonPressed:);
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}
//only saves note when the nav goes back
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
      
        NSLog(@"check");
            if (![self.notes.text isEqualToString:@""]) {
                [self.delegate inputController:self didFinishWithText:self.notes.text getTitle:self.Title.text getPhoto:self.imageView.image];
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

//email actions
-(IBAction)emailButtonPressed:(UIBarButtonItem*)sender{
    // email title
    NSString *emailTitle = self.Title.text;
    // Email Content
    NSString *messageBody = self.notes.text;
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"lih2105@columbia.edu"];
    
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.mailComposeDelegate = self;
    [mailVC setSubject:emailTitle];
    [mailVC setMessageBody:messageBody isHTML:NO];
    NSData *imageData = [[NSData alloc]initWithData:UIImagePNGRepresentation(self.imageView.image)];
    [mailVC addAttachmentData:imageData mimeType:@"image/jpeg" fileName:self.Title.text];
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
//user chosoe image
-(IBAction)imageButtonPressed:(UIBarButtonItem*)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker
                       animated:YES
                     completion:nil];
}

//gets image
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
