//
//  ViewController_AboutUs.m
//  AggieFix
//
//  Created by Myunghoon Lee (Haru) on 10/5/15.
//  Copyright © 2015 Engineers Serving the Community. All rights reserved.
//

#import "ViewController_AboutUs.h"

@interface ViewController_AboutUs ()

@end

@implementation ViewController_AboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)exit:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
