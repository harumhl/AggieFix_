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
    UIAlertController *photoOption = [UIAlertController alertControllerWithTitle:@"Photo option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
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
    // FOR THE BELOW CASE, THIS CAN HAPPEN ONLY IF THE INFO IS GIVEN. TEST IF SO. 
    NSString *emailBody = [NSString stringWithFormat:@"%@%@%@\n%@%@\n%@%@",
                           @"Howdy Sir or Madame,\n\n",
                           @"Latitude: ", [defaults objectForKey:@"latitude"],
                           @"Longitude: ", [defaults objectForKey:@"longitude"],
                           @"Address: ", [defaults objectForKey:@"address"]];
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
        
        // GIVE CONFIRMATION IF ADDED SUCCESSFULLY
    }];
    [getLocation addAction:getCurrentLocation]; // put the alert in the alertController list
    
    // 2nd option
    UIAlertAction* enterCurrentLocation = [UIAlertAction actionWithTitle:@"Enter Current Location manually" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // Action to be taken -> enter Current Location manually
        // SHOW POPUP COMMENT SPOT TO TYPE
/*      loadPhoto = [[UIImagePickerController alloc] init];
        loadPhoto.delegate = self;
        [loadPhoto setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:loadPhoto animated:YES completion:NULL];*/
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
        NSString *saveLatitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSString *saveLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        [defaults setObject:saveLatitude forKey:@"latitude"];
        [defaults setObject:saveLongitude forKey:@"longitude"];
        [defaults synchronize];
    }
    
    // Convert geocoder's info to human-readable friendly, place it in placemark
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil && [placemarks count] >0) {
            placemark = [placemarks lastObject];
            
            // Save it in the UserDefaults (or the shared database) so I can use the info for email
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *saveAddress = [NSString stringWithFormat:@"%@ %@, %@, %@ %@",
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

@end