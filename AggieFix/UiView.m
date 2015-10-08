//
//  UiView.m
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 10/6/15.
//  Copyright © 2015 Engineers Serving the Community. All rights reserved.
//

#import "UiView.h"

@implementation UiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// Text fields move accordingly as keyboard shows up
// https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html#//apple_ref/doc/uid/TP40009542-CH5-SW1
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{/*
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWasShown:)
                                             name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    */
}
// Called when the UIKeyboardDidShowNotification is sent.
@end
