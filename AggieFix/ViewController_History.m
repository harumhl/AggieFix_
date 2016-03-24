//
//  ViewController+History.m
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 3/15/16.
//  Copyright © 2016 Engineers Serving the Community. All rights reserved.
//

#import "ViewController_History.h"

@implementation ViewController (History)

- (void)resetNSUserDefaults {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

@end