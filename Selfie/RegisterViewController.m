//
//  RegisterViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 02/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//


#import "RegisterViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()
{
    AppDelegate * appDelegate;
    UITapGestureRecognizer * tap;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

        appDelegate.timeInterval = 5;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)hideKeyboard
{
    [_usernameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [_countryTextField resignFirstResponder];
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

- (IBAction)registerButtonPressed:(id)sender {
    
    
    appDelegate.username = _usernameTextField.text;
    PFObject * userObject = [PFObject objectWithClassName:@"Users"];
    userObject[@"username"]=_usernameTextField.text;
    userObject[@"email"]=_emailTextField.text;
    userObject[@"country"]=_countryTextField.text;
    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        [self performSegueWithIdentifier:@"showCameraView" sender:self];

        }
    }];
    
}
@end
