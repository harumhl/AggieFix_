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

@interface ViewController_Report : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    
    IBOutlet UIScrollView *scroller;    // Making the screen scrollable
    IBOutlet UITextView *commentBox;
   
    
    UIImagePickerController* takePhoto; // bring camera to take a picture as an attachment
    UIImagePickerController* loadPhoto; // bring photo app for an attachment
    UIImage *image;                     // display the photo to be sent
    IBOutlet UIImageView *imageView;    // display the photo to be sent
    IBOutlet UIButton *clickForPicture;
    
    UILabel *added;                     // Display if geotagging was done successfully
    CLLocationManager *locationManager; // main variable for geotagging
    CLGeocoder *geocoder;               // contains location info (not human-readable friendly)
    CLPlacemark *placemark;             // contains converted info from geocoder in human-readable
    
    IBOutlet UITextField *categories;
    UIPickerView *myPickerView;         // For Picker view for Categories
    NSArray *pickerArray;
    
    // TEMP LABEL WHETHER EMAIL IS SENT
    IBOutlet UILabel *isEmailSent;
}


// Dismiss Keyboard when "Done" is pressed
//http://code.tutsplus.com/tutorials/ios-sdk-uitextview-uitextviewdelegate--mobile-11210
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

// Shows two (or three, third to cancel) options to choose photos from
// https://www.youtube.com/watch?v=4s-C3f6kQp4 display alert button list
// https://www.youtube.com/watch?v=T7COfFjhXo8 button -> camera, photo app
- (IBAction)photoOption:(id)sender;

// Send email NOT FULLY IMPLEMENTED YET B/C OF SIMULATOR LIMITATION
// https://www.youtube.com/watch?v=00rKDuIqEt0
// https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/SystemMessaging_TopicsForIOS/Articles/SendingaMailMessage.html
// https://books.google.com/books?id=ZZkQAwAAQBAJ&pg=PA130&lpg=PA130&dq=xcode+if+email+is+sent&source=bl&ots=yd-HRXmJCm&sig=WNXV_0Du0cq4ZWpevDSaMPLAtnc&hl=en&sa=X&ved=0CE4Q6AEwB2oVChMI_7jj2NeJyQIVy-smCh2sOA3K#v=onepage&q=xcode%20if%20email%20is%20sent&f=false
- (IBAction)displayComposerSheet:(id)sender;

// Get current location
// https://www.youtube.com/watch?v=qY4xCMTejH8
// http://stackoverflow.com/questions/25916841/cllocationmanager-startupdatinglocation-not-calling-locationmanagerdidupdateloc
- (IBAction)getCurrentLocation:(id)sender;      // Gets the current location via geotagging

// Picker view for Categories
// http://www.tutorialspoint.com/ios/ios_ui_elements_picker.htm
-(void)addPickerView;
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
-(NSInteger)pickerView:(UIPickerView *)pickerView;
-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component;
-(void)doneWithPickerView;

@end