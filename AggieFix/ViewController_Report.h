//
//  ViewController_Report
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 9/15/15.
//  Copyright (c) 2015 Engineers Serving the Community. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController_Report : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    IBOutlet UIScrollView *scroller;
    IBOutlet UITextField *titleText;
    IBOutlet UILabel *loaded;
    
    IBOutlet UILabel *photoOptionSelected;
    
    UIImagePickerController* takePhoto;
    UIImagePickerController* loadPhoto;
    UIImage *image;
    IBOutlet UIImageView *imageView;
}

// https://www.youtube.com/watch?v=NavVADVU6fk
- (IBAction)saveText:(id)sender;
- (IBAction)loadText:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

// https://www.youtube.com/watch?v=4s-C3f6kQp4
- (IBAction)photoOption:(id)sender;

// https://www.youtube.com/watch?v=T7COfFjhXo8
- (IBAction)takePhoto:(id)sender;
- (IBAction)chooseExisting:(id)sender;
@end
