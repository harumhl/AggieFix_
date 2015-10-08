//
//  ViewController_Report
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 9/15/15.
//  Copyright (c) 2015 Engineers Serving the Community. All rights reserved.
//

#import "ViewController_Report.h"

@interface ViewController_Report ()

@end

@implementation ViewController_Report

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Making the screen scrollable
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 768)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//==============================================================================
// TEMPORARY function to show text saving from title field && loading from saved
- (IBAction)saveText:(id)sender {
    NSString *saveTitleText = titleText.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveTitleText forKey:@"titleText"];
    [defaults synchronize];
}
- (IBAction)loadText:(id)sender {
    // load the saved info to the label
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadTitleText = [defaults objectForKey:@"titleText"];
    [loaded setText:loadTitleText];

}
- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}
//==============================================================================
- (IBAction)photoOption:(id)sender {
    UIAlertController *photoOption = [UIAlertController alertControllerWithTitle:@"Photo option" message:@"" preferredStyle:UIAlertViewStyleDefault];
    
    // 1st option
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> bring camera
        takePhoto = [[UIImagePickerController alloc] init];
        takePhoto.delegate = self;
        [takePhoto setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:takePhoto animated:YES completion:NULL];
    }];
    [photoOption addAction:defaultAction]; // put the alert in the alertController list
    
    // 2nd option
    UIAlertAction* anotherAction = [UIAlertAction actionWithTitle:@"Get photo from photo app" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> bring photo app
        loadPhoto = [[UIImagePickerController alloc] init];
        loadPhoto.delegate = self;
        [loadPhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:loadPhoto animated:YES completion:NULL];
    }];
    [photoOption addAction:anotherAction]; // put the alert in the alertController list
    
    // Cancel option
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { // do nothing but just dismiss the option list
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [photoOption addAction:cancelAction]; // put the alert in the alertController list


    // present
    [self presentViewController:photoOption animated:YES completion:nil];
}

//==============================================================================
// Get the image from either camera or photo app and display it
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//==============================================================================
// Send email
// THIS PORTION IS INCOMPLETE SINCE THE SIMULATOR DOESN'T WORK FOR EMAILS
// I PURPOSELY DID NOT IMPLEMENT ATTACHING THE IMAGE FROM THE SOURCE, BECAUSE OF IT.
// AS WELL AS GETTING THE EMAIL BODY TEXT AND SPLASH SCREEN IF SUCCESSFULLY SENT
- (IBAction)displayComposerSheet:(id)sender{
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    // Set the title
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadTitleText = [defaults objectForKey:@"titleText"];
    NSString *organizationTitle = @"AggieFix_";
    NSString *wholeTitle = [organizationTitle stringByAppendingString:loadTitleText];
    [mailComposer setSubject:wholeTitle];
    
    // Set up the recipients. // pass NSArray
    [mailComposer setToRecipients:@[@"haru.mhl@gmail.com"]];
    
    // Attach an image to the email.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ipodnano"
                                                     ofType:@"png"];
    NSData *myData = [NSData dataWithContentsOfFile:path];
    [mailComposer addAttachmentData:myData mimeType:@"image/png"
                     fileName:@"ipodnano"];
    
    // Fill out the email body text.
    NSString *emailBody = @"It is raining in sunny California!";
    [mailComposer setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentViewController:mailComposer animated:YES completion:nil];
        // [self presentModalViewController:mailComposer animated:YES]; since it depreciated
}

// The mail compose view controller delegate method
// TO SHOW SPLASH SCREEN, I NEED TO GET THE VALUE OF "RESULT" TO KNOW WHETHER SUCCESSFULLY SENT
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
        // [self dismissModalViewControllerAnimated:YES]; since it depreciated
}

@end