//
//  ViewController+History.h
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 3/15/16.
//  Copyright © 2016 Engineers Serving the Community. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (History)

// I WILL TRY TO CREATE 'REPORT' OBJECTS AND KEEP IT IN AN NSARRAY TO DISPLAY IT IN A TABLE VIEW

// ONCE AN EMAIL IS SUCCESSFULLY SENT, THEN CREATE AN OBJECT AND PUSH BACK INTO THE ARRAY AS IT SHOWS THAT IT iS SUCCESSFULLY SENT.

// http://stackoverflow.com/questions/6797096/delete-all-keys-from-a-nsuserdefaults-dictionary-iphone
- (void)resetNSUserDefaults;

// https://agilewarrior.wordpress.com/2012/02/06/how-to-display-thumbnail-images-in-iphone-table-view/
// display images in table view

@end
