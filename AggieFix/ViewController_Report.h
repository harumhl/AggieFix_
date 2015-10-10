//
//  ViewController_Report
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 9/15/15.
//  Copyright (c) 2015 Engineers Serving the Community. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>         // for sending email
#import <CoreLocation/CoreLocation.h>   // for geotagging

@interface ViewController_Report : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate> {
    
    IBOutlet UIScrollView *scroller;    // Making the screen scrollable
    IBOutlet UITextField *titleText;    // title text field
    IBOutlet UILabel *loaded;           // TEMPORARY label to check "save" and "load" works
        
    UIImagePickerController* takePhoto; // bring camera to take a picture as an attachment
    UIImagePickerController* loadPhoto; // bring photo app for an attachment
    UIImage *image;                     // display the photo to be sent
    IBOutlet UIImageView *imageView;    // display the photo to be sent
    
    IBOutlet UILabel *displayLatitude;         // TEMPORARY label to display latitude
    IBOutlet UILabel *displayLongitude;        // TEMPORARY label to display longitude
    IBOutlet UILabel *displayAddress;          // TEMPORARY label to display address
    CLLocationManager *locationManager;        // main variable for geotagging
    CLGeocoder *geocoder;                      // contains location info (not human-readable friendly)
    CLPlacemark *placemark;                    // contains converted info from geocoder in human-readable
}

// Save data from text field
// https://www.youtube.com/watch?v=NavVADVU6fk
- (IBAction)saveText:(id)sender;        // TEMPORARY function to show text saving from title field
- (IBAction)loadText:(id)sender;        // TEMPORARY function to show text loading from saved
- (IBAction)dismissKeyboard:(id)sender; // dismiss keyboard when hit "return" FOR ONLY TITLE

// Shows two (or three, third to cancel) options to choose photos from
// https://www.youtube.com/watch?v=4s-C3f6kQp4 display alert button list
// https://www.youtube.com/watch?v=T7COfFjhXo8 button -> camera, photo app
- (IBAction)photoOption:(id)sender;

// Send email NOT FULLY IMPLEMENTED YET B/C OF SIMULATOR LIMITATION
// https://www.youtube.com/watch?v=00rKDuIqEt0
// https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/SystemMessaging_TopicsForIOS/Articles/SendingaMailMessage.html
- (IBAction)displayComposerSheet:(id)sender;

// Get current location
// https://www.youtube.com/watch?v=qY4xCMTejH8
// http://stackoverflow.com/questions/25916841/cllocationmanager-startupdatinglocation-not-calling-locationmanagerdidupdateloc
- (IBAction)getCurrentLocation:(id)sender;      // Gets the current location via geotagging

@end