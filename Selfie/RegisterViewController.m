//
//  RegisterViewController.m
//  Selfie
//
//  Created by Shubham Sorte on 02/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 75.0

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()
{
    AppDelegate * appDelegate;

}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

        appDelegate.timeInterval = 5;
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.usernameTextField.delegate = self;
    self.countryTextField.delegate = self;
    self.emailTextField.delegate = self;

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    _countryTextField.text = appDelegate.country;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _usernameTextField) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y - 85, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    if (textField == _emailTextField) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y - 125, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    if (textField ==_countryTextField) {
        [self performSegueWithIdentifier:@"showCountry" sender:self];
    }


}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _usernameTextField||_emailTextField) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_usernameTextField resignFirstResponder];
    [_countryTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
}

@end
