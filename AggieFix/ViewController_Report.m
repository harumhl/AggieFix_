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
    
    
    commentBox.delegate = self;
    
    
    // Making the screen scrollable
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 768)];
    
    [self addPickerView];
    
    // Empty automatic geographic location data
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"geoCurrentLocation"]; // flag
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"longitude_latitude"]; // geotag 1
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"address"];            // geotag 2
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"manualLocation"];     // entering
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
// Dismiss Keyboard when "Done" is pressed
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

//==============================================================================
- (IBAction)photoOption:(id)sender {
    UIAlertController *photoOption = [UIAlertController alertControllerWithTitle:@"Photo option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 1st option
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> bring camera
        takePhoto = [[UIImagePickerController alloc] init];
        takePhoto.delegate = self;
        [takePhoto setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:takePhoto animated:YES completion:NULL];

        clickForPicture.titleLabel.hidden = YES;
}];
    
    [photoOption addAction:defaultAction]; // put the alert in the alertController list
    
    // 2nd option
    UIAlertAction* anotherAction = [UIAlertAction actionWithTitle:@"Get photo from photo app" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> bring photo app
        loadPhoto = [[UIImagePickerController alloc] init];
        loadPhoto.delegate = self;
        [loadPhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:loadPhoto animated:YES completion:NULL];

        clickForPicture.titleLabel.hidden = YES;
    }];
    
    [photoOption addAction:anotherAction]; // put the alert in the alertController list
    
    // View picture if one is already selected
    CGImageRef cgref = [image CGImage];
    CIImage *cim = [image CIImage];
    
    if (!(cim == nil && cgref == NULL)) { // If there is am image available in UIImage "image" 
        
        
        UIAlertAction* viewAction = [UIAlertAction actionWithTitle:@"View selected photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

            // NEED TO IMPLEMENT TO DISPLAY CURRENTLY SELECTED PHOTO IN FULL SCREEN!
            
        }];
        [photoOption addAction:viewAction];
    }

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
    NSString *loadChosenCategory = [defaults objectForKey:@"chosenCategory"]; // NOT FROM PREVIOUS SESSION!!!
    NSString *organizationTitle = @"AggieFix_";
    NSString *wholeTitle = [organizationTitle stringByAppendingString:loadChosenCategory];
    [mailComposer setSubject:wholeTitle];
    
    // Set up the recipients. // pass NSArray
    [mailComposer setToRecipients:@[@"haru.mhl@gmail.com"]];
    
    // Attach an image to the email.
    NSData *theImage = UIImagePNGRepresentation(image);
    [mailComposer addAttachmentData:theImage
                       mimeType:@"image/png"
                       fileName:@"Photo.png"];

    
    // Fill out the email body text.
    // FOR THE BELOW CASE, THIS CAN HAPPEN ONLY IF THE INFO IS GIVEN. TEST IF SO.
    NSString *emailBody;
    
    // Testing if location information is given
    if ([defaults objectForKey:@"geoCurrentLocation"] != nil) {
        
        emailBody = [NSString stringWithFormat:@"%@%@%@",
                     @"Howdy Sir or Madame,\n\n",
                     [defaults objectForKey:@"longitude_latitude"],
                     [defaults objectForKey:@"address"]];

    }
    else if ([defaults objectForKey:@"manualLocation"] != nil) {
        
        emailBody = [NSString stringWithFormat:@"%@%@", @"Howdy Sir or Madame,\n\n", [defaults objectForKey:@"manualLocation"]];
    }
    else { // If no location information is given, either by geotagging nor manual entering, then prompt an alert
        UIAlertController *askForLocation = [UIAlertController alertControllerWithTitle:@"Can you enter location information?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* promptForLocation = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];

        
        [askForLocation addAction:promptForLocation]; // put the alert in the alertController list

        [self presentViewController:askForLocation animated:YES completion:nil];
    }

    [mailComposer setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentViewController:mailComposer animated:YES completion:nil];
        // [self presentModalViewController:mailComposer animated:YES]; since it depreciated
}

// The mail compose view controller delegate method
// TO SHOW SPLASH SCREEN, I NEED TO GET THE VALUE OF "RESULT" TO KNOW WHETHER SUCCESSFULLY SENT
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    if (result == MFMailComposeResultSent) {
        [isEmailSent setText:@"Email sent"];
        /*
        UIAlertController *emailSent = [UIAlertController alertControllerWithTitle:@"Email Sent" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];// or UIAlertControllerStyleAlert
        
        // 1st option
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        [emailSent addAction:defaultAction]; // put the alert in the alertController list
        
        // present
        [self presentViewController:emailSent animated:YES completion:nil];*/
        
    }
    else if (result == MFMailComposeResultCancelled) {
        [isEmailSent setText:@"Email cancelled"];
    }
    else if (result == MFMailComposeResultFailed) {
        [isEmailSent setText:@"Email failed to send"];
    }
    else if (result == MFMailComposeResultSaved) {
        [isEmailSent setText:@"Email saved"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//==============================================================================
// Shows two options whether to get current location or enter it manually
// Copied the skeleton code from photoOption
- (IBAction)getCurrentLocation:(id)sender {
    UIAlertController *getLocation = [UIAlertController alertControllerWithTitle:@"Get Location" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    // 1st option
    UIAlertAction* getCurrentLocation = [UIAlertAction actionWithTitle:@"Get Current Location" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> get Current Location
        locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // this portion (3 lines) is from the StackOverflow website - getting permission
        locationManager.distanceFilter=kCLDistanceFilterNone;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startMonitoringSignificantLocationChanges];
        
        [locationManager startUpdatingLocation];
        
        // Making a note that it is added
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"geoCurrentLocation"];

        
        // GIVE CONFIRMATION IF ADDED SUCCESSFULLY
    }];
    [getLocation addAction:getCurrentLocation]; // put the alert in the alertController list
    
    // 2nd option
    UIAlertAction* enterCurrentLocation = [UIAlertAction actionWithTitle:@"Enter Current Location manually" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> enter Current Location manually

        // Show another alert with blank (to type with keyboard)
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter Location here" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        // Button option
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
            // Saving the location data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[alert.textFields objectAtIndex:0].text forKey:@"manualLocation"];
        }];
        
        [alert addAction:defaultAction];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {}];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    [getLocation addAction:enterCurrentLocation]; // put the alert in the alertController list
    
    // Cancel option
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { // do nothing but just dismiss the option list
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [getLocation addAction:cancelAction]; // put the alert in the alertController list
    
    
    // present
    [self presentViewController:getLocation animated:YES completion:nil];
}
#pragma mark CLLocationManagerDelegate Methods

// If Geotagging fails
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location.");
    [added setText:@"← failed to geotag"];

    
    // Error Domain=kCLErrorDomain Code=0 "(null)"
    // The above error means the wifi setting or Internet setting is bad.
    // There may not be any problem with the code
}
// If Geotagging works, then get the information as formatted
// THIS NEEDS WORK LIKE ->> CONTINUOUS UPDATE IF IT'S ON, BUT IF APP IS OFF THEN OFF (NO BACKGROUND)
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    // Update location from the given array
    // NSLog(@"Location: %@",[locations lastObject]); -> uncomment to see what information it contains
    CLLocation *currentLocation = [locations lastObject];
    
    // Display coordinates in labels
    if (currentLocation != nil) {
        // Save it in the UserDefaults (or the shared database) so I can use the info for email
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *saveLongitudeLatitude = [NSString stringWithFormat:@"%@%@\n%@%@\n",
         @"Longitude: ", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude],
         @"Latitude: ", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]];
        [defaults setObject:saveLongitudeLatitude forKey:@"longitude_latitude"];
        [defaults synchronize];
        
        [added setText:@"← Added successfully"]; // WHAT IF IT'S DONE SEVERAL TIMES????
    }
    
    // Convert geocoder's info to human-readable friendly, place it in placemark
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil && [placemarks count] >0) {
            placemark = [placemarks lastObject];
            
            // Save it in the UserDefaults (or the shared database) so I can use the info for email
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *saveAddress = [NSString stringWithFormat:@"%@%@ %@, %@, %@ %@",
                                        @"Address: ",
                                        placemark.subThoroughfare,    placemark.thoroughfare,
                                        placemark.locality, placemark.administrativeArea,
                                        placemark.postalCode];
            [defaults setObject:saveAddress forKey:@"address"];
            [defaults synchronize];

        } else {
            NSLog(@"%@", error.debugDescription);}
    }];
    
}
//==============================================================================
// Picker View for Categories
-(void)addPickerView{
    pickerArray = [[NSArray alloc] initWithObjects:@"Desks",
                   @"Sprinklers",@"Lights",@"Water Fountain",@"Others", nil];
    
    myPickerView = [[UIPickerView alloc] init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneWithPickerView)];

    // toolbar = where 'done' button is at.
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     myPickerView.frame.size.height-50, 320, 40)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton, nil];
    [toolBar setItems:toolbarItems];
    
    categories.inputView = myPickerView;
    categories.inputAccessoryView = toolBar;
    
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component{
    // Saving the chosen category info, so it can be used as the email title
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *saveChosenCategory = [pickerArray objectAtIndex:row];
    [defaults setObject:saveChosenCategory forKey:@"chosenCategory"];

    // Showing the chosen category in the text field
    [categories setText:[pickerArray objectAtIndex:row]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row]; // For Display of Options
}

-(void)doneWithPickerView {
    [self->categories resignFirstResponder];
}
//==============================================================================




@end