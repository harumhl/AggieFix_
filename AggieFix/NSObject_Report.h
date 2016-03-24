//
//  NSObject+Report.h
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 3/15/16.
//  Copyright © 2016 Engineers Serving the Community. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> // UIImage

@interface NSObject (Report)

@property UIImage   *photo;
@property NSString  *category;
@property NSString  *comment;
@property BOOL      *geoTag;
@property NSString  *geoInfo; // if (geotag) then longitute+latitute+address, else manual input

@end
